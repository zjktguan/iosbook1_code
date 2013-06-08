//
//  ViewController.m
//  HTTPQueue
//
//  Created by 关东升 on 12-12-21.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClick:(id)sender {
    
    NSString *strURL1 = @"http://iosbook1.com/service/upload.php";
    
	NSURL *url1 = [NSURL URLWithString:[strURL1 URLEncodedString]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url1];
    [request setPostValue:@"<你的iosbook1.com用户邮箱>" forKey:@"email"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"jpg"];
    
    [request setFile:path forKey:@"file"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestSuccess:)];
    [request setDidFailSelector:@selector(requestError:)];
    [request startAsynchronous];
    
}

- (void)requestSuccess:(ASIHTTPRequest *)request
{
    NSData *data = [request responseData];
    NSError *eror;
    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&eror];
    if (!resDict) {
        
        //查看图片
        [self seeImage];
        

    } else {
        NSNumber *resultCodeObj = [resDict objectForKey:@"ResultCode"];
        
        NSString *errorStr = [resultCodeObj errorMessage];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误信息"
                                                            message:errorStr
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)requestError:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",[error localizedDescription]);
}

-(void)seeImage
{
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://iosbook1.com/service/download.php?email=%@&FileName=1.jpg",@"<你的iosbook1.com用户邮箱>"];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        NSData *data  = [request responseData];
        
        UIImage *img = [UIImage imageWithData:data];
        _imageView1.image = img;
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"%@", [error localizedDescription]);
        
    }];
    [request startAsynchronous];
}

@end

//
//  ViewController.m
//  ActivityIndicatorViewProgressViewSample
//
//  Created by cherry on 12-9-7.
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
@synthesize myTimer;

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

- (IBAction)startToMove:(id)sender
{
    if ([self.myActivityIndicatorView isAnimating]) {
        [self.myActivityIndicatorView stopAnimating];
    }else{
        [self.myActivityIndicatorView startAnimating];
    }
}

- (IBAction)downloadProgress:(id)sender
{
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                               target:self
                                             selector:@selector(download)
                                             userInfo:nil
                                              repeats:YES];
}
-(void)download{
    self.myProgressView.progress=self.myProgressView.progress+0.1;
    if (self.myProgressView.progress==1.0) {
        [myTimer invalidate];
        UIAlertView*alert=[[UIAlertView  alloc]initWithTitle:@"download completed！"
                                                     message:@""
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
        [alert show];
    }
    
}
@end

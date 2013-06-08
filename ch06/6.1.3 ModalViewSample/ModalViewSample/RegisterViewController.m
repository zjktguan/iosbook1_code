//
//  RegisterViewController.m
//  ModalViewSample
//
//  Created by 关东升 on 12-9-17.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Modal View done");
        
        NSDictionary *dataDict = [NSDictionary dictionaryWithObject:self.txtUsername.text
                                                             forKey:@"username"];
        [[NSNotificationCenter defaultCenter]
                postNotificationName:@"RegisterCompletionNotification"
                object:nil
                userInfo:dataDict];
        
    }];
    
}
@end

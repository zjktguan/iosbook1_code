//
//  FlipsideViewController.m
//  NotificationSample
//
//  Created by 关东升 on 12-8-31.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleTerminate:)
                                                 name:@"AppWillTerminateNotification"
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];    
    
}

#pragma mark - 处理通知
-(void)handleTerminate:(NSNotification*)notification
{
    NSDictionary *theData = [notification userInfo];
    if (theData != nil) {
        NSDate *date = [theData objectForKey:@"TerminateDate"];
        NSLog(@"FlipsideViewController App Terminate Date: %@", date);
    }
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end

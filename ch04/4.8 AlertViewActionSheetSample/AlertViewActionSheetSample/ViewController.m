//
//  ViewController.m
//  AlertViewActionSheetSample
//
//  Created by 关东升 on 12-8-5.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
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
}

- (IBAction)testAlertView:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Alert"
                              message:@"Alert text goes here"
                              delegate:self
                              cancelButtonTitle:@"No"
                              otherButtonTitles:@"Yes", nil];
    [alertView show];
}



- (IBAction)testActionSheet:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
								 initWithTitle:nil
								 delegate:self
								 cancelButtonTitle:@"取消"
								 destructiveButtonTitle:@"破坏性按钮"
								 otherButtonTitles:@"Fackbook",@"新浪微博",nil];
	
	actionSheet.actionSheetStyle =  UIActionSheetStyleAutomatic;
	[actionSheet showInView:self.view];

}

#pragma  mark-- 实现UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"buttonIndex = %i",buttonIndex);
    
}

#pragma  mark-- 实现UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %i",buttonIndex);
}

@end

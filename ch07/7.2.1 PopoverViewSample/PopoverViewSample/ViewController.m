//
//  ViewController.m
//  PopoverViewSample
//
//  Created by 关东升 on 12-9-24.
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
	
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)show:(id)sender {
    
    
    SelectViewController *popoverViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectViewController"];
    
    if (self.poc == nil) {
        
//        popoverViewController.title = @"选择你喜欢的颜色";
//        UINavigationController *nav = [[UINavigationController alloc]
//                                       initWithRootViewController:popoverViewController];
        self.poc  = [[UIPopoverController alloc] initWithContentViewController:popoverViewController];

    }
    
    [self.poc presentPopoverFromBarButtonItem:sender
                     permittedArrowDirections:UIPopoverArrowDirectionUp
                                     animated:YES];
    
}


@end

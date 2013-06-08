//
//  ViewController.m
//  ScrollViewSample
//
//  Created by 关东升 on 12-9-5.
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
	self.scrollView.contentSize = CGSizeMake(320, 600);
}


-(void)viewDidAppear:(BOOL)animated
{
        
    [self.scrollView setContentOffset:CGPointMake(0, 110) animated:YES];
    //self.scrollView.contentOffset = CGPointMake(0, 110);
    NSLog(@" self.scrollView.contentSize %f,%f", self.scrollView.contentSize.height, self.scrollView.contentSize.width);
    
    [super viewDidAppear:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  DelegatePattern
//
//  Created by 关东升 on 12-8-28.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "ViewController.h"
#import "Philosopher.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    Philosopher *obj = [[Philosopher alloc ] init];
    obj.delegate = self;
    [obj start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -- PhilosopherDelegate 方法实现
-(void) sleep
{
    NSLog(@"sleep...");
}

-(void) eat
{
     NSLog(@"eat...");
}

-(void) work
{
     NSLog(@"work...");
}




@end

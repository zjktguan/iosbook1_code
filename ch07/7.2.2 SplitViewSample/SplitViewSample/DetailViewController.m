//
//  DetailViewController.m
//  SplitViewSample
//
//  Created by 关东升 on 12-9-24.
//  Copyright (c) 2012年 智捷东方科技有限公司（www.51work6.com）. All rights reserved.
//  本书服务网站 http://www.iosbook1.com
//  配套视频网站 http://v.51work6.com
//  关老师 新浪微博： @tony_关东升  http://weibo.com/516inc
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"blueViewController"];
    self.yellowViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"yellowViewController"];
    
    [self.view addSubview: self.blueViewController.view ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//根据行号更新视图
-(void)updateView:(int)row
{
    if (row == 0) {//蓝色
        
        if (self.yellowViewController.view.superview) {//黄色视图存在则移除
            [self.yellowViewController.view removeFromSuperview];
        }
        if (self.blueViewController.view.superview == nil) {//添加蓝色视图存
            [self.view addSubview: self.blueViewController.view ];
        }
    } else {
        if (self.blueViewController.view.superview) {//蓝色视图存在则移除
            [self.blueViewController.view removeFromSuperview];
        }
        if (self.yellowViewController.view.superview == nil) {//添加黄色视图存
            [self.view addSubview: self.yellowViewController.view ];
        }
    }
    
}


@end

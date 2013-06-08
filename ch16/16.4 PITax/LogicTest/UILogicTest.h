//
//  UILogicTest.h
//  UILogicTest
//
//  Created by 关东升 on 12-10-22.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "ViewController.h"

@interface UILogicTest : SenTestCase
{
    id txtField;
    id label;
    ViewController *controller;
}

@property (nonatomic, strong) id txtField;
@property (nonatomic, strong) id label;
@property (nonatomic, strong) ViewController *controller;

-(void)testCalculateWithOnClick;

@end
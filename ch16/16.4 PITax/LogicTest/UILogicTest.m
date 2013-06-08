//
//  UILogicTest.m
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

#import "UILogicTest.h"

@implementation UILogicTest

@synthesize txtField;
@synthesize label;
@synthesize controller;

- (void)setUp
{
    [super setUp];
    
    txtField = (id)[OCMockObject mockForClass:[UITextField class]];
    label = (id)[OCMockObject mockForClass:[UILabel class]];
    controller = [[ViewController alloc] init];
    
    //设置视图控制器中的控件
    //设置文本字段控件属性
    [controller setValue:txtField forKey:@"txtRevenue"];
    //设置标签控件属性
    [controller setValue:label forKey:@"lblTax"];
}

- (void)tearDown
{
    
    [txtField verify];
    [label verify];
    
    self.txtField = nil;
    self.label = nil;
    self.controller = nil;
    [super tearDown];
}

-(void)testCalculateWithOnClick
{
    [[[txtField stub] andReturn:@"5000"] text];
    [[txtField expect] resignFirstResponder];
    
    [[label expect] setText: @"45.00"];

    //测试按钮点击事件
    [controller onClick:OCMOCK_ANY];

}


@end

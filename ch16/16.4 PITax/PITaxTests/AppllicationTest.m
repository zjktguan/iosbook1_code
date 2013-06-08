//
//  AppllicationTest.m
//  AppllicationTest
//
//  Created by 关东升 on 12-10-24.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "AppllicationTest.h"

@implementation AppllicationTest

- (void)setUp
{
    [super setUp];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    UIWindow *window = [appDelegate window];
    
    UINavigationController *navController = (UINavigationController*)window.rootViewController;
    self.viewController  = (ViewController*)navController.topViewController;
    //self.viewController  = [[ViewController alloc] init];

}

- (void)tearDown
{
    self.viewController = nil;
    
    [super tearDown];
}


//测试不输入直接点击计算按钮
- (void)testOnClickInputBlank
{
    STAssertNotNil(self.viewController, @"ViewController没有赋值。");
    //设定输入值
    self.viewController.txtRevenue.text = @"";
    //调用oncClick测试
    [self.viewController onClick:nil];
    //取得输出结果
    NSString* strTax = self.viewController.lblTax.text;
    //断言
    STAssertEqualObjects(strTax, @"0.00", @"期望值是：0.00 实际值是：%@", strTax);

}


//测试整数
- (void)testOnClickInputIntegerNumber
{
    STAssertNotNil(self.viewController, @"ViewController没有赋值。");
    //设定输入值
    self.viewController.txtRevenue.text = @"8000";
    //调用oncClick测试
    [self.viewController onClick:nil];
    //取得输出结果
    NSString* strTax = self.viewController.lblTax.text;
    //断言
    STAssertEqualObjects(strTax, @"345.00", @"期望值是：345.00 实际值是：%@", strTax);
    
}

//测试小数
- (void)testOnClickInputOneDot
{
    STAssertNotNil(self.viewController, @"ViewController没有赋值。");
    //设定输入值
    self.viewController.txtRevenue.text = @"8000.59";
    //调用oncClick测试
    [self.viewController onClick:nil];
    //取得输出结果
    NSString* strTax = self.viewController.lblTax.text;
    //断言
    STAssertEqualObjects(strTax, @"345.12", @"期望值是：345.12 实际值是：%@", strTax);
    
}


//测试输入两个小数点
- (void)testOnClickInputTwoDot
{
    STAssertNotNil(self.viewController, @"ViewController没有赋值。");
    //设定输入值
    self.viewController.txtRevenue.text = @"40000.50.56";
    //调用oncClick测试
    [self.viewController onClick:nil];
    //取得输出结果
    NSString* strTax = self.viewController.lblTax.text;
    //断言
    STAssertEqualObjects(strTax, @"8195.15", @"期望值是：8195.15 实际值是：%@", strTax);    
}

//测试有前导0数据
- (void)testOnClickInputPrefixZero
{
    STAssertNotNil(self.viewController, @"ViewController没有赋值。");
    //设定输入值
    self.viewController.txtRevenue.text = @"08000.59";
    //调用oncClick测试
    [self.viewController onClick:nil];
    //取得输出结果
    NSString* strTax = self.viewController.lblTax.text;
    //断言
    STAssertEqualObjects(strTax, @"345.12", @"期望值是：345.12 实际值是：%@", strTax);
    
}

//测试连在一起两个小数点 
- (void)testOnClickInputLinkDot
{
    STAssertNotNil(self.viewController, @"ViewController没有赋值。");
    //设定输入值
    self.viewController.txtRevenue.text = @"40000.50..56";
    //调用oncClick测试
    [self.viewController onClick:nil];
    //取得输出结果
    NSString* strTax = self.viewController.lblTax.text;
    //断言
    STAssertEqualObjects(strTax, @"8195.15", @"期望值是：8195.15 实际值是：%@", strTax);
    
}

@end

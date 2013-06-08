//
//  PITaxTest.m
//  PITaxTest
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

#import "PITaxTest.h"

@implementation PITaxTest

- (void)setUp
{
    self.viewController = [[ViewController alloc] init];
    
}

- (void)tearDown
{
    self.viewController = nil;

}

//测试月应纳税额不超过1500元 用例1
- (void)testCalculateLevel1
{    
    double dbRevenue = 5000;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    if ([strTax doubleValue] == 45) {
        NSLog(@"testCalculateLevel1测试通过。");
    } else {
        NSLog(@"testCalculateLevel1测试失败，期望值是：45 实际值是：%@。", strTax);
    }
}

//测试月应纳税额超过1500元至4500元 用例2
- (void)testCalculateLevel2
{   
    double dbRevenue = 8000;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    if ([strTax doubleValue] == 345) {
        NSLog(@"testCalculateLevel2测试通过。");
    } else {
        NSLog(@"testCalculateLevel2测试失败，期望值是：345 实际值是：%@。", strTax);
    }
    
}

//测试月应纳税额超过4500元至9000元 用例3
- (void)testCalculateLevel3
{   
    double dbRevenue = 12500;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    if ([strTax doubleValue] == 1245) {
        NSLog(@"testCalculateLevel3测试通过。");
    } else {
        NSLog(@"testCalculateLevel3测试失败，期望值是：1245 实际值是：%@。", strTax);
    }
    
}


//测试月应纳税额超过9000元至35000元 用例4
- (void)testCalculateLevel4
{   
    double dbRevenue = 38500;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    if ([strTax doubleValue] == 7745) {
        NSLog(@"testCalculateLevel4测试通过。");
    } else {
        NSLog(@"testCalculateLevel4测试失败，期望值是：7745 实际值是：%@。", strTax);
    }
}

//测试月应纳税额超过35000元至55000元 用例5
- (void)testCalculateLevel5
{    
    double dbRevenue = 58500;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    if ([strTax doubleValue] == 13745) {
        NSLog(@"testCalculateLevel5测试通过。");
    } else {
        NSLog(@"testCalculateLevel5测试失败，期望值是：13745 实际值是：%@。", strTax);
    }
}


//测试月应纳税额超过55000元至80000元 用例6
- (void)testCalculateLevel6
{    
    double dbRevenue = 83500;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    if ([strTax doubleValue] == 22495) {
        NSLog(@"testCalculateLevel6测试通过。");
    } else {
        NSLog(@"testCalculateLevel6测试失败，期望值是：22495 实际值是：%@。", strTax);
    }
}

//测试月应纳税额超过80000元 用例7
- (void)testCalculateLevel7
{   
    double dbRevenue = 103500;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    if ([strTax doubleValue] == 31495) {
        NSLog(@"testCalculateLevel7测试通过。");
    } else {
        NSLog(@"testCalculateLevel7测试失败，期望值是：31495 实际值是：%@。", strTax);
    }
    
}

@end

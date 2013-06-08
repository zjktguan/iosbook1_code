//
//  MyGHTests.m
//  MyGHTests
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


#import <GHUnitIOS/GHUnit.h> 


@interface MyGHTests : GHTestCase { }
@end

@implementation MyGHTests

- (void)testEqualStrings {
    
    GHTestLog(@"比较两个字符串是否相等。");
    NSString *string1 = @"abc";
    // 断言string1不是nil的
    GHAssertNotNil(string1, nil);
    
     
    NSString *string2 = @"ABC";
    // 断言对象相等   
    GHAssertEqualObjects(string1, string2, @"string1 应该等于: %@.", string2);
}

@end

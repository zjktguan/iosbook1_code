//
//  PITaxTest.h
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

#import "ViewController.h"

@interface PITaxTest : NSObject


@property (nonatomic,strong) ViewController *viewController;

- (void)setUp;

- (void)tearDown;

//测试月应纳税额不超过1500元 用例1
- (void)testCalculateLevel1;
- (void)testCalculateLevel2;
- (void)testCalculateLevel3;
- (void)testCalculateLevel4;
- (void)testCalculateLevel5;
- (void)testCalculateLevel6;
- (void)testCalculateLevel7;


@end

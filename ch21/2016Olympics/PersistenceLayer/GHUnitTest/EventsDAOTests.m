//
//  EventsDAOTests.m
//  PersistenceLayer
//
//  Created by 关东升 on 12-11-22.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <GHUnitIOS/GHUnit.h>
#import "EventsDAO.h"
#import "Events.h"
#import "DBHelper.h"

@interface EventsDAOTests : GHTestCase {}

@property (nonatomic,strong) EventsDAO * dao;
@property (nonatomic,strong) Events * theEvents;

@end

@implementation EventsDAOTests


- (void)setUpClass {
    
    //创建EventsDAO对象
    self.dao = [EventsDAO sharedManager];
    //创建Events对象
    self.theEvents = [[Events alloc] init];
    self.theEvents.EventName = @"test EventName";
    self.theEvents.EventIcon = @"test EventIcon";
    self.theEvents.KeyInfo = @"test KeyInfo";
    self.theEvents.BasicsInfo = @"test BasicsInfo";
    self.theEvents.OlympicInfo = @"test OlympicInfo";
}

- (void)tearDownClass {
    self.dao = nil;
}

- (void)setUp {}

- (void)tearDown { }

//测试 插入Events方法
-(void) test_1_Create
{
    int res = [self.dao create:self.theEvents];
    //断言 无异常，返回值为0，
    GHAssertTrueNoThrow(res == 0, @"数据插入失败");
    
}

//测试 按照主键查询数据方法
-(void) test_2_FindById
{
    self.theEvents.EventID = 41;
    Events* resEvents = [self.dao findById:self.theEvents];
    //断言 查询结果非nil
    GHAssertNotNil(resEvents, @"查询记录为nil");
    //断言
    GHAssertEqualObjects(self.theEvents.EventName ,resEvents.EventName, @"比赛项目名测试失败");
    GHAssertEqualObjects(self.theEvents.EventIcon ,resEvents.EventIcon, @"比赛项目图标测试失败");
    GHAssertEqualObjects(self.theEvents.KeyInfo ,resEvents.KeyInfo, @"项目关键信息测试失败");
    GHAssertEqualObjects(self.theEvents.BasicsInfo ,resEvents.BasicsInfo, @"项目基本信息测试失败");
    GHAssertEqualObjects(self.theEvents.OlympicInfo ,resEvents.OlympicInfo, @"项目奥运会历史信息测试失败");
}

//测试 查询所有数据方法
-(void) test_3_FindAll
{
    NSArray* list =  [self.dao findAll];
    //断言 查询记录数为1
    GHAssertTrue([list count] == 41, @"查询记录数期望值为：42 实际值为：%i", [list count]);
    
    Events* resEvents  = list[40];
    //断言
    GHAssertEqualObjects(self.theEvents.EventName ,resEvents.EventName, @"比赛项目名测试失败");
    GHAssertEqualObjects(self.theEvents.EventIcon ,resEvents.EventIcon, @"比赛项目图标测试失败");
    GHAssertEqualObjects(self.theEvents.KeyInfo ,resEvents.KeyInfo, @"项目关键信息测试失败");
    GHAssertEqualObjects(self.theEvents.BasicsInfo ,resEvents.BasicsInfo, @"项目基本信息测试失败");
    GHAssertEqualObjects(self.theEvents.OlympicInfo ,resEvents.OlympicInfo, @"项目奥运会历史信息测试失败");
}

//测试 修改Events方法
-(void) test_4_Modify
{
    self.theEvents.EventID = 41;
    self.theEvents.EventName = @"test modify EventName";
    
    int res = [self.dao modify:self.theEvents];
    //断言 无异常，返回值为0
    GHAssertTrueNoThrow(res == 0, @"数据修改失败");
    
    Events* resEvents = [self.dao findById:self.theEvents];
    //断言 查询结果非nil
    GHAssertNotNil(resEvents, @"查询记录为nil");
    //断言
    GHAssertEqualObjects(self.theEvents.EventName ,resEvents.EventName, @"比赛项目名测试失败");
    GHAssertEqualObjects(self.theEvents.EventIcon ,resEvents.EventIcon, @"比赛项目图标测试失败");
    GHAssertEqualObjects(self.theEvents.KeyInfo ,resEvents.KeyInfo, @"项目关键信息测试失败");
    GHAssertEqualObjects(self.theEvents.BasicsInfo ,resEvents.BasicsInfo, @"项目基本信息测试失败");
    GHAssertEqualObjects(self.theEvents.OlympicInfo ,resEvents.OlympicInfo, @"项目奥运会历史信息测试失败");
    
}

//测试 删除数据方法
-(void) test_5_Remove
{
    int res =   [self.dao remove:self.theEvents];
    //断言 无异常，返回值为0
    GHAssertTrueNoThrow(res == 0, @"数据修改失败");

    Events* resEvents = [self.dao findById:self.theEvents];
    //断言 查询结果nil
    GHAssertNil(resEvents, @"记录删除失败");

}

@end

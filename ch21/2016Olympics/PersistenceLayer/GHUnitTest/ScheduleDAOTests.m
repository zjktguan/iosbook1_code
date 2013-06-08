//
//  ScheduleDAOTests.m
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
#import "ScheduleDAO.h"
#import "Schedule.h"

@interface ScheduleDAOTests : GHTestCase {}

@property (nonatomic,strong) ScheduleDAO * dao;
@property (nonatomic,strong) Schedule * theSchedule;

@end

@implementation ScheduleDAOTests


- (void)setUpClass {

    //创建ScheduleDAO对象
    self.dao = [ScheduleDAO sharedManager];
    //创建Schedule对象
    self.theSchedule = [[Schedule alloc] init];
    self.theSchedule.GameDate = @"test GameDate";
    self.theSchedule.GameTime = @"test GameTime";
    self.theSchedule.GameInfo = @"test GameInfo";
    self.theSchedule.Event.EventID = 1;
}

- (void)tearDownClass {
    self.dao = nil;
}

- (void)setUp {}

- (void)tearDown { }

//测试 插入Schedule方法
-(void) test_1_Create
{
    int res = [self.dao create:self.theSchedule];
    //断言 无异常，返回值为0，
    GHAssertTrueNoThrow(res == 0, @"数据插入失败");
    
}

//测试 按照主键查询数据方法
-(void) test_2_FindById
{
    self.theSchedule.ScheduleID = 502;
    Schedule* resSchedule = [self.dao findById:self.theSchedule];
    //断言 查询结果非nil
    GHAssertNotNil(resSchedule, @"查询记录为nil");
    //断言
    GHAssertEqualObjects(self.theSchedule.GameDate ,resSchedule.GameDate, @"比赛日期测试失败");
    GHAssertEqualObjects(self.theSchedule.GameTime ,resSchedule.GameTime, @"比赛时间测试失败");
    GHAssertEqualObjects(self.theSchedule.GameInfo ,resSchedule.GameInfo, @"比赛描述测试失败");
    GHAssertEquals(self.theSchedule.Event.EventID ,resSchedule.Event.EventID, @"比赛项目测试失败");
}

//测试 查询所有数据方法
-(void) test_3_FindAll
{
    NSArray* list =  [self.dao findAll];
    //断言 查询记录数为1
    GHAssertTrue([list count] == 502, @"查询记录数期望值为：42 实际值为：%i", [list count]);
    
    Schedule* resSchedule  = list[501];
    //断言
    GHAssertEqualObjects(self.theSchedule.GameDate ,resSchedule.GameDate, @"比赛日期测试失败");
    GHAssertEqualObjects(self.theSchedule.GameTime ,resSchedule.GameTime, @"比赛时间测试失败");
    GHAssertEqualObjects(self.theSchedule.GameInfo ,resSchedule.GameInfo, @"比赛描述测试失败");
    GHAssertEquals(self.theSchedule.Event.EventID ,resSchedule.Event.EventID, @"比赛项目测试失败");
}

//测试 修改Schedule方法
-(void) test_4_Modify
{
    self.theSchedule.ScheduleID = 502;
    self.theSchedule.GameInfo = @"test modify GameInfo";
    
    int res = [self.dao modify:self.theSchedule];
    //断言 无异常，返回值为0
    GHAssertTrueNoThrow(res == 0, @"数据修改失败");
    
    Schedule* resSchedule = [self.dao findById:self.theSchedule];
    //断言 查询结果非nil
    GHAssertNotNil(resSchedule, @"查询记录为nil");
    //断言
    GHAssertEqualObjects(self.theSchedule.GameDate ,resSchedule.GameDate, @"比赛日期测试失败");
    GHAssertEqualObjects(self.theSchedule.GameTime ,resSchedule.GameTime, @"比赛时间测试失败");
    GHAssertEqualObjects(self.theSchedule.GameInfo ,resSchedule.GameInfo, @"比赛描述测试失败");
    GHAssertEquals(self.theSchedule.Event.EventID ,resSchedule.Event.EventID, @"比赛项目测试失败");
    
}

//测试 删除数据方法
-(void) test_5_Remove
{
    int res =   [self.dao remove:self.theSchedule];
    //断言 无异常，返回值为0
    GHAssertTrueNoThrow(res == 0, @"数据修改失败");

    Schedule* resSchedule = [self.dao findById:self.theSchedule];
    //断言 查询结果nil
    GHAssertNil(resSchedule, @"记录删除失败");

}

@end

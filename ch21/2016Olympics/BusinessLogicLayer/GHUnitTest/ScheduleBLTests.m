//
//  ScheduleBLTests.m
//  BusinessLogicLayer
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
#import "ScheduleBL.h"
#import "Schedule.h"
#import "ScheduleDAO.h"

@interface ScheduleBLTests : GHTestCase {}

@property (nonatomic,strong) ScheduleBL * bl;
@property (nonatomic,strong) Schedule * theSchedule;

@end

@implementation ScheduleBLTests


- (void)setUpClass {
    
    //创建ScheduleBL对象
    self.bl = [ScheduleBL new];
    //创建Schedule对象
    self.theSchedule = [Schedule new];
    self.theSchedule.GameDate = @"test GameDate";
    self.theSchedule.GameTime = @"test GameTime";
    self.theSchedule.GameInfo = @"test GameInfo";
    Events *event = [Events new];
    event.EventName = @"Cycling Mountain Bike";
    event.EventID = 10;
    self.theSchedule.Event = event;
    
    //插入测试数据
    ScheduleDAO *dao = [ScheduleDAO sharedManager];
    [dao create:self.theSchedule];
}

- (void)tearDownClass {
    
    //删除测试数据
    self.theSchedule.ScheduleID = 502;
    ScheduleDAO *dao = [ScheduleDAO sharedManager];
    [dao remove:self.theSchedule];
    
    self.bl = nil;
}

- (void)setUp {}

- (void)tearDown { }

//测试 按照主键查询数据方法
-(void) testFindAll
{
    
    NSMutableDictionary* dict =  [self.bl readData];
    
    NSArray  *allkey = [dict allKeys];
    
    //断言 查询记录数为1
    GHAssertTrue([allkey count] == 18, @"断言比赛天数");
    
    NSArray* schedules  = [dict objectForKey:self.theSchedule.GameDate];
    Schedule* resSchedule  = schedules[0];
    //断言
    GHAssertEqualObjects(self.theSchedule.GameDate ,resSchedule.GameDate, @"比赛日期测试失败");
    GHAssertEqualObjects(self.theSchedule.GameTime ,resSchedule.GameTime, @"比赛时间测试失败");
    GHAssertEqualObjects(self.theSchedule.GameInfo ,resSchedule.GameInfo, @"比赛描述测试失败");
    GHAssertEquals(self.theSchedule.Event.EventID ,resSchedule.Event.EventID, @"比赛项目ID测试失败");
    GHAssertEqualObjects(self.theSchedule.Event.EventName ,resSchedule.Event.EventName, @"比赛项目名测试失败");

}

@end

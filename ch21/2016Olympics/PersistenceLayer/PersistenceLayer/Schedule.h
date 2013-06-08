//
//  Schedule.h
//  PersistenceLayer
//
//  Created by 关东升 on 12-11-21.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <Foundation/Foundation.h>
#import "Events.h"

// 比赛日程表 实体类
@interface Schedule : NSObject

//编号
@property(nonatomic, assign) NSUInteger ScheduleID;
//比赛日期
@property(nonatomic, strong) NSString* GameDate;
//比赛时间
@property(nonatomic, strong) NSString* GameTime;
//比赛描述
@property(nonatomic, strong) NSString* GameInfo;
//比赛项目
@property(nonatomic, strong) Events* Event;

@end

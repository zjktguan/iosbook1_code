//
//  EventsDAO.h
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
#import "BaseDAO.h"
#import "Events.h"
#import "EventsDAO.h"

//比赛项目 数据访问对象类
@interface EventsDAO : BaseDAO

+ (EventsDAO*)sharedManager;

//插入Note方法
-(int) create:(Events*)model;

//删除Note方法
-(int) remove:(Events*)model;

//修改Note方法
-(int) modify:(Events*)model;

//查询所有数据方法
-(NSMutableArray*) findAll;

//按照主键查询数据方法
-(Events*) findById:(Events*)model;


@end

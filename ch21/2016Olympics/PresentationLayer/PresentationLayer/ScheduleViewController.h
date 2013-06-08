//
//  ScheduleViewController_iPhone.h
//  2016Olympics
//
//  Created by 关东升 on 12-11-23.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <UIKit/UIKit.h>
#import "Schedule.h"
#import "ScheduleBL.h"
#import "EventsDetailViewController.h"

@interface ScheduleViewController : UITableViewController

//表视图使用的数据
@property (strong, nonatomic) NSDictionary * data;
//比赛日期列表
@property (strong, nonatomic) NSArray * arrayGameDateList;


@end

//
//  Events.h
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

//比赛项目 实体类
@interface Events : NSObject

//编号
@property(nonatomic, assign) NSUInteger EventID;
//项目名
@property(nonatomic, strong) NSString* EventName;
//项目图标
@property(nonatomic, strong) NSString* EventIcon;
//项目关键信息
@property(nonatomic, strong) NSString* KeyInfo;
//项目基本信息
@property(nonatomic, strong) NSString* BasicsInfo;
//项目奥运会历史信息
@property(nonatomic, strong) NSString* OlympicInfo;

@end

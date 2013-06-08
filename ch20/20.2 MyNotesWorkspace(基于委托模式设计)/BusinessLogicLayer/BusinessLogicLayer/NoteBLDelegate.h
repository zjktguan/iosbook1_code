//
//  NoteBLDelegate.h
//  BusinessLogicLayer
//
//  Created by 关东升 on 12-12-22.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

@protocol NoteBLDelegate

@optional
//查询所有数据方法 成功
- (void)findAllNotesFinished:(NSMutableArray *)list;
//查询所有数据方法 失败
- (void)findAllNotesFailed:(NSError *)error;

//插入Note方法 成功
- (void)createNoteFinished;
//插入Note方法 失败
- (void)createNoteFailed:(NSError *)error;

//删除Note方法 成功
- (void)removeNoteFinished;
//删除Note方法 失败
- (void)removeNoteFailed:(NSError *)error;

//修改Note方法 成功
- (void)modifyNoteFinished;
//修改Note方法 失败
- (void)modifyNoteFailed:(NSError *)error;


@end

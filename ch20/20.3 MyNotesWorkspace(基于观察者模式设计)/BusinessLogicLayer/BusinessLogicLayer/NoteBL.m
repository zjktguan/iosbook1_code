//
//  NoteBL.m
//  MyNotes
//
//  Created by 关东升 on 12-9-26.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "NoteBL.h"

@implementation NoteBL

-(id)init
{
    self = [super init];
    if (self) {
        _dao = [NoteDAO new];
    }
    return self;
}


//插入Note方法
-(void) createNote:(Note*)model
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createFinished:)
                                                 name:DaoCreateFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createFailed:)
                                                 name:DaoCreateFailedNotification
                                               object:nil];
    [_dao create:model];
}

//删除Note方法
-(void) removeNote:(Note*)model
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeFinished:)
                                                 name:DaoRemoveFinishedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeFailed:)
                                                 name:DaoRemoveFailedNotification
                                               object:nil];
    [_dao remove:model];
}

//查询所有数据方法
-(void) findAllNotes
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findAllFinished:)
                                                 name:DaoFindAllFinishedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findAllFailed:)
                                                 name:DaoFindAllFailedNotification
                                               object:nil];
    
    [_dao findAll];
}


//修改数据方法
-(void) modifyNote:(Note*)model
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifyFinished:)
                                                 name:DaoModifyFinishedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifyFailed:)
                                                 name:DaoModifyFailedNotification
                                               object:nil];
    [_dao modify:model];
}


//查询所有数据方法 成功
- (void)findAllFinished:(NSNotification*)notification
{
    NSMutableArray *resList = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:BLFindAllFinishedNotification object:resList];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoFindAllFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoFindAllFailedNotification object:nil];
}

//查询所有数据方法 失败
- (void)findAllFailed:(NSNotification*)notification
{
    NSError *error = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:BLFindAllFailedNotification object:error];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoFindAllFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoFindAllFailedNotification object:nil];
}

//插入Note方法 成功
- (void)createFinished:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BLCreateNoteFinishedNotification object:nil];
}

//插入Note方法 失败
- (void)createFailed:(NSNotification*)notification
{
    NSError *error = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:BLCreateNoteFailedNotification object:error];
}

//删除Note方法 成功
- (void)removeFinished:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BLRemoveFinishedNotification object:nil];
}
//删除Note方法 失败
- (void)removeFailed:(NSNotification*)notification
{
    NSError *error = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:BLRemoveFailedNotification object:error];
}
//修改Note方法 成功
- (void)modifyFinished:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BLModifyFinishedNotification object:nil];
}

//修改Note方法 失败
- (void)modifyFailed:(NSNotification*)notification
{
    NSError *error = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:BLModifyFailedNotification object:error];
}

@end

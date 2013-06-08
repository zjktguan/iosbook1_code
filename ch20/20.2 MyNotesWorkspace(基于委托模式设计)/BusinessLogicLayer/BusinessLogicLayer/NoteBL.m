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

-(id) init
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
    _dao.delegate = self;
    [_dao create:model];
}

//删除Note方法
-(void) removeNote:(Note*)model
{
    _dao.delegate = self;
    [_dao remove:model];
}

//查询所有数方法
-(void) findAllNotes
{
    _dao.delegate = self;
    [_dao findAll];
}


//修改数据方法
-(void) modifyNote:(Note*)model
{
    _dao.delegate = self;
    [_dao modify:model];
}

#pragma --mark NoteDAODelegate 委托方法
//查询所有数据方法 成功
- (void)findAllFinished:(NSMutableArray *)list
{
    [_delegate findAllNotesFinished:list];
}

//查询所有数据方法 失败
- (void)findAllFailed:(NSError *)error
{
    [_delegate findAllNotesFailed:error];
}

//插入Note方法 成功
- (void)createFinished
{
    [_delegate createNoteFinished];
}

//插入Note方法 失败
- (void)createFailed:(NSError *)error
{
    [_delegate createNoteFailed:error];
}

//删除Note方法 成功
- (void)removeFinished
{
    [_delegate removeNoteFinished];
}
//删除Note方法 失败
- (void)removeFailed:(NSError *)error
{
    [_delegate removeNoteFailed:error];
}
//修改Note方法 成功
- (void)modifyFinished
{
    [_delegate modifyNoteFinished];
}

//修改Note方法 失败
- (void)modifyFailed:(NSError *)error
{
    [_delegate modifyNoteFailed:error];
}

@end

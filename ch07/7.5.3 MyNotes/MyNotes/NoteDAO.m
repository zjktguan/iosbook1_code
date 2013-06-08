//
//  NoteDAO.m
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

#import "NoteDAO.h"

@implementation NoteDAO


static NoteDAO *sharedManager = nil;

+ (NoteDAO*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date1 = [dateFormatter dateFromString:@"2010-08-04 16:01:03"];
        Note* note1 = [[Note alloc] init];
        note1.date = date1;
        note1.content = @"Welcome to MyNote.";
        
        NSDate *date2 = [dateFormatter dateFromString:@"2011-12-04 16:01:03"];
        Note* note2 = [[Note alloc] init];
        note2.date = date2;
        note2.content = @"欢迎使用MyNote。";
        
        sharedManager = [[self alloc] init];
        sharedManager.listData = [[NSMutableArray alloc] init];
        [sharedManager.listData addObject:note1];
        [sharedManager.listData addObject:note2];
        
    });
    return sharedManager;
}

//插入Note方法
-(int) create:(Note*)model
{
    
    [self.listData addObject:model];
    return 0;
}

//删除Note方法
-(int) remove:(Note*)model
{
    for (Note* note in self.listData) {
        //比较日期主键是否相等
        if ([note.date isEqualToDate:model.date]){
            [self.listData removeObject: note];
            break;
        }
    }
    
    return 0;
}

//修改Note方法
-(int) modify:(Note*)model
{
    for (Note* note in self.listData) {
        //比较日期主键是否相等
        if ([note.date isEqualToDate:model.date]){
            note.content = model.content;
            break;
        }
    }
    return 0;
}

//查询所有数据方法
-(NSMutableArray*) findAll
{
    return self.listData;
}

//按照主键查询数据方法
-(Note*) findById:(Note*)model
{
    for (Note* note in self.listData) {
        //比较日期主键是否相等
        if ([note.date isEqualToDate:model.date]){
            return note;
        }
    }
    return nil;
}


@end

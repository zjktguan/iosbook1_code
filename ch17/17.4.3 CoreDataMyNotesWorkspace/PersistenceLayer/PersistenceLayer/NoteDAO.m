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
        
        sharedManager = [[self alloc] init];
        [sharedManager managedObjectContext];
        
    });
    return sharedManager;
}


//插入Note方法
-(int) create:(Note*)model
{
    
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NoteManagedObject *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:cxt];
    [note setValue: model.content forKey:@"content"];
    [note setValue: model.date forKey:@"date"];
    
    note.date = model.date;
    note.content = model.content;
    
    NSError *savingError = nil;
    if ([self.managedObjectContext save:&savingError]){
        NSLog(@"插入数据成功");
    } else {
        NSLog(@"插入数据失败");
        return -1;
    }
    
    return 0;
}

//删除Note方法
-(int) remove:(Note*)model
{
    
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Note" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"date =  %@", model.date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
        [self.managedObjectContext deleteObject:note];
        
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]){
            NSLog(@"删除数据成功");
        } else {
            NSLog(@"删除数据失败");
            return -1;
        }
    }
    
    return 0;
}

//修改Note方法
-(int) modify:(Note*)model
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Note" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"date =  %@", model.date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
        note.content = model.content;
        
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]){
            NSLog(@"修改数据成功");
        } else {
            NSLog(@"修改数据失败");
            return -1;
        }
    }
    return 0;
}

//查询所有数据方法
-(NSMutableArray*) findAll
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Note" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
//    //限制一次提取数据的记录数
    [request setFetchLimit:50];
//    //限制一次提取数据的记录书
//    [request setFetchOffset:10];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    NSMutableArray *resListData = [[NSMutableArray alloc] init];
    
    for (NoteManagedObject *mo in listData) {
        Note *note = [[Note alloc] init];
        note.date = mo.date;
        note.content = mo.content;
        [resListData addObject:note];
    }
    
    return resListData;
}

//按照主键查询数据方法
-(Note*) findById:(Note*)model
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Note" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"date =  %@",model.date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    if ([listData count] > 0) {
        NoteManagedObject *mo = [listData lastObject];
        
        Note *note = [[Note alloc] init];
        note.date = mo.date;
        note.content = mo.content;
        
        return note;
    }
    return nil;
}



@end

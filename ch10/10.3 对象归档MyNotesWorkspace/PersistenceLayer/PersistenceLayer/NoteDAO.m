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
        [sharedManager createEditableCopyOfDatabaseIfNeeded];               
    });
    return sharedManager;
}


- (void)createEditableCopyOfDatabaseIfNeeded {
	
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writableDBPath = [self applicationDocumentsDirectoryFile];
	
	BOOL dbexits = [fileManager fileExistsAtPath:writableDBPath];
	if (!dbexits) {
        
        NSString *path = [self applicationDocumentsDirectoryFile];
        
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
        
        NSMutableArray* array  = [[NSMutableArray alloc] init];

        
        [array addObject:note1];
        [array addObject:note2];
        
        NSMutableData * theData = [NSMutableData data];
        NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc]
                                      initForWritingWithMutableData:theData];
        [archiver encodeObject:array forKey:ARCHIVE_KEY];
        [archiver finishEncoding];
        
        [theData writeToFile:path atomically:YES];
	}
}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:FILE_NAME];
	return path;
}


//插入Note方法
-(int) create:(Note*)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [self findAll];
    
    [array addObject:model];    
    
    NSMutableData * theData = [NSMutableData data];
	NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc]
                                  initForWritingWithMutableData:theData];
	[archiver encodeObject:array forKey:ARCHIVE_KEY];
	[archiver finishEncoding];
	[theData writeToFile:path atomically:YES];
	
    return 0;
}

//删除Note方法
-(int) remove:(Note*)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [self findAll];
    
    for (Note* note in array) {
        
        //比较日期主键是否相等
        if ([note.date isEqualToDate:model.date]){
            [array removeObject: note];
            
            NSMutableData * theData = [NSMutableData data];
            NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc]
                                          initForWritingWithMutableData:theData];
            [archiver encodeObject:array forKey:ARCHIVE_KEY];
            [archiver finishEncoding];
            [theData writeToFile:path atomically:YES];
            
            break;
        }
    }
    
    return 0;
}

//修改Note方法
-(int) modify:(Note*)model
{
    
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [self findAll];
    
    for (Note* note in array) {
        
        //比较日期主键是否相等
        if ([note.date isEqualToDate:model.date]){
            
            note.content = model.content;
            
            NSMutableData * theData = [NSMutableData data];
            NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc]
                                          initForWritingWithMutableData:theData];            
            [archiver encodeObject:array forKey:ARCHIVE_KEY];
            [archiver finishEncoding];
            
            [theData writeToFile:path atomically:YES];
            
            break;
        }
    }
    return 0;
}

//查询所有数据方法
-(NSMutableArray*) findAll
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    NSData * theData =[NSData dataWithContentsOfFile:path];
    
    if([theData length] > 0) {
		NSKeyedUnarchiver * archiver = [[NSKeyedUnarchiver alloc]
                                        initForReadingWithData:theData];
		listData = [archiver decodeObjectForKey:ARCHIVE_KEY];
		[archiver finishDecoding];

	}
    return listData;
}

//按照主键查询数据方法
-(Note*) findById:(Note*)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    NSData * theData =[NSData dataWithContentsOfFile:path];
    
    if([theData length] > 0) {
		NSKeyedUnarchiver * archiver = [[NSKeyedUnarchiver alloc]
                                        initForReadingWithData:theData];
		listData = [archiver decodeObjectForKey:ARCHIVE_KEY];
		[archiver finishDecoding];
        
        for (Note* note in listData) {
            
            //比较日期主键是否相等
            if ([note.date isEqualToDate:model.date]){
                return note;
            }
        }
	}
    return nil;
}


@end

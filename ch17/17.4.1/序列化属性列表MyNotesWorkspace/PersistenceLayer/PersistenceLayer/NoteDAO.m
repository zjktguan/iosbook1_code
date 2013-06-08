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
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"NotesList.plist"];
        
        //读取资源文件中源plist文件
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:defaultDBPath];
    
        [self write:array toFilePath:writableDBPath];   
	
	}
}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.binary"];
    
	return path;
}


//插入Note方法
-(int) create:(Note*)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray* array = [self readFromArray:path];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDictionary* dict = [NSDictionary
                          dictionaryWithObjects:@[[dateFormat stringFromDate: model.date],model.content]
                          forKeys:@[@"date",@"content"]];
    
    [array addObject:dict];
    
    [self write:array toFilePath:path];   
    
    return 0;
}

//删除Note方法
-(int) remove:(Note*)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray* array = [self readFromArray:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        
        //比较日期主键是否相等
        if ([date isEqualToDate:model.date]){
            [array removeObject: dict];
            [self write:array toFilePath:path];   
            break;
        }
    }
    
    return 0;
}

//修改Note方法
-(int) modify:(Note*)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray* array = [self readFromArray:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        NSString* content = [dict objectForKey:@"content"];
        
        //比较日期主键是否相等
        if ([date isEqualToDate:model.date]){
            [dict setValue:content forKey:@"content"];            
            [self write:array toFilePath:path];            
            break;
        }
    }
    return 0;
}

//查询所有数据方法
-(NSMutableArray*) findAll
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray* array = [self readFromArray:path];
    
    //返回给服务层的数据
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        Note* note = [[Note alloc] init];
        note.date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        note.content = [dict objectForKey:@"content"];
        
        [listData addObject:note];
        
    }
    return listData;
}

//按照主键查询数据方法
-(Note*) findById:(Note*)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray* array = [self readFromArray:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        Note* note = [[Note alloc] init];
        note.date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        note.content = [dict objectForKey:@"content"];
        
        //比较日期主键是否相等
        if ([note.date isEqualToDate:model.date]){
            return note;
        }
    }
    return nil;
}

//从文件中读取数据到NSMutableArray
-(NSMutableArray*) readFromArray: (NSString*) path
{
    //从文件读取到NSMutableData
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:path];
    //反序列化到属性列表对象（NSMutableArray）
    NSMutableArray* array = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainersAndLeaves format: NULL error:NULL];
    
    return array;
}

//写入NSMutableArray数据到文件中
-(void) write:(NSMutableArray*)array toFilePath: (NSString*) path
{
    //把属性列表对象（NSMutableArray）序列化为NSData
    NSData * data = [NSPropertyListSerialization dataWithPropertyList:array format:NSPropertyListBinaryFormat_v1_0 options:NSPropertyListMutableContainersAndLeaves error:NULL];
    
    //写入到沙箱目录的序列化文件
    BOOL success = [data writeToFile:path atomically:YES];
    
    if (!success) {
        NSAssert(0, @"错误写入文件");
    }
}

@end

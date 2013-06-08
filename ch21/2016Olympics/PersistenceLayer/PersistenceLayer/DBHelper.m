//
//  DBHelper.m
//  PersistenceLayer
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

#import "DBHelper.h"

@implementation DBHelper

//初始化并加载数据
-(void) initDB
{
    
    NSString* configTablePath = [[NSBundle mainBundle] pathForResource:@"DBConfig" ofType:@"plist"];
    NSDictionary*  configTable =  [[NSDictionary alloc] initWithContentsOfFile:configTablePath];
    //从配置文件获得数据版本号
    NSNumber *dbConfigVersion = [configTable objectForKey:@"DB_VERSION"];
    //从数据库DBVersionInfo表记录返回的数据库版本号
    int versionNubmer = [self dbVersionNubmer];
    
    //版本号不一致
    if ([dbConfigVersion intValue] != versionNubmer)
    {
        NSString* dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
        
        if (sqlite3_open([dbFilePath UTF8String], &db) != SQLITE_OK) {
            sqlite3_close(db);
            NSAssert(NO,@"数据库打开失败。");
        } else {
            //加载数据到业务表中
            NSLog(@"数据库升级...");
            char *err;
            
            NSString * createtablePath = [[NSBundle mainBundle] pathForResource:@"create_load" ofType:@"sql"];
            
            NSString* sql = [[NSString alloc]  initWithContentsOfFile:createtablePath
                                                             encoding:NSUTF8StringEncoding error:nil];
            
            if (sqlite3_exec(db,[sql UTF8String],NULL,NULL,&err) != SQLITE_OK) {
                NSLog(@"数据库升级失败原因 : %@",[NSMutableString stringWithCString:err encoding: NSUTF8StringEncoding]);
            }
            
            //把当前版本号写回到文件中
            NSString* usql = [[NSString alloc] initWithFormat: @"update  DBVersionInfo set version_number = %i", [dbConfigVersion intValue]];
            if (sqlite3_exec(db,[usql UTF8String],NULL,NULL,&err) != SQLITE_OK) {
                NSLog(NO,@"更新DBVersionInfo数据失败。");
            }
            
            sqlite3_close(db);
        }
    }
}

- (int) dbVersionNubmer
{
    NSString* dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
    
    int versionNubmer = -1;
    
    if (sqlite3_open([dbFilePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO,@"数据库打开失败。");
    } else {
        NSString* sql = @"create table if not exists DBVersionInfo ( version_number int );";
        if (sqlite3_exec(db,[sql UTF8String],NULL,NULL,NULL) != SQLITE_OK) {
            NSLog(NO,@"创建表失败。");
        }
        
        NSString* qsql = @"select version_number from DBVersionInfo";
        
        sqlite3_stmt *statement;
		//预处理过程
		if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
			if (sqlite3_step(statement) == SQLITE_ROW) { //有数据情况
                NSLog(@"有数据情况");
                versionNubmer = sqlite3_column_int(statement, 0);
			} else {//无数据情况，插入数据
                NSLog(@"无数据情况");
                NSString* csql = @"insert into DBVersionInfo (version_number) values(-1)";
                if (sqlite3_exec(db,[csql UTF8String],NULL,NULL,NULL) != SQLITE_OK) {
                    NSLog(NO,@"插入数据失败。");
                }
            }
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(db);
    }
    
    return versionNubmer;
}



+(NSString *)applicationDocumentsDirectoryFile:(NSString *)fileName {
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:fileName];
    
	return path;
}

@end

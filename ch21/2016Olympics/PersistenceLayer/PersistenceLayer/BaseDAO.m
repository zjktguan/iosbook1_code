//
//  BaseDAO.m
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

#import "BaseDAO.h"

@implementation BaseDAO

- (id)init
{
    self = [super init];
    if (self)
    {
        
        self.dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
        //初始化数据库
        DBHelper *dbhelper = [DBHelper new];
        [dbhelper initDB];
        
    }
    
    return self;
}

-(BOOL)openDB
{
    if (sqlite3_open([self.dbFilePath UTF8String], &db) != SQLITE_OK) {
		sqlite3_close(db);
		NSLog(@"数据库打开失败。");
        return false;
	}
    return true;
}

@end

//
//  NotesNextiveJsonParser.m
//  MyNotes
//
//  Created by 关东升 on 12-12-13.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "NotesNextiveJsonParser.h"

@implementation NotesNextiveJsonParser

-(void)start
{
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"json"];
    
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    
    NXJsonParser* jsonParser = [[NXJsonParser alloc] initWithData:jsonData];
    id jsonObj = [jsonParser parse:nil ignoreNulls:NO];
	
    if (!jsonObj) {
        NSLog(@"JSON数据解析失败。");
        return;
    }
    
    _notes = [jsonObj objectForKey:@"Record"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.notes userInfo:nil];
    self.notes = nil;

}

@end

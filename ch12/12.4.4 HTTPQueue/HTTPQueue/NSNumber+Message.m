//
//  NSNumber+Message.m
//  MyNotes
//
//  Created by 关东升 on 12-5-25.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//
//

#import "NSNumber+Message.h"

@implementation NSNumber (Message)

-(NSString *)errorMessage
{
	/*  -7 没有数据。
    *  	-6 日期没有输入。
    *  	-5 内容没有输入。
    *  	-4 ID没有输入。
    *  	-3 据访问失败。
    *	-2 您的账号最多能插入10条数据。
    *	-1 用户不存在，请到http://iosbook1.com注册。
    *	0 查询成功	
    *	1 修改成功
    */
    
    NSString *errorStr = @"";
    
    switch ([self integerValue]) {
        case -9:
            errorStr = @"文件没有指定。";
            break;
        case -8:
            errorStr = @"文件找不到。";
            break;
        case -7:
            errorStr = @"没有数据。";
            break;
        case -6:
            errorStr = @"日期没有输入。";
            break;
        case -5:
            errorStr = @"内容没有输入。";
            break;
        case -4:
            errorStr = @"ID没有输入。";
            break;
        case -3:
            errorStr = @"据访问失败。";
            break;
        case -2:
            errorStr = @"您的账号最多能插入10条数据。";
            break;            
        case -1:
            errorStr = @"用户不存在，请到http://iosbook1.com注册。";
        default:
            break;
    }
    
    return errorStr;
}

@end

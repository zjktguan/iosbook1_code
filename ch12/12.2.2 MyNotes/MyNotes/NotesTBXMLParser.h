//
//  NotesTBXMLParser.h
//  MyNotes
//
//  Created by 关东升 on 12-12-12.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "TBXML.h"

@interface NotesTBXMLParser : NSObject

//解析出的数据内部是字典类型
@property (strong,nonatomic) NSMutableArray *notes;

//开始解析
-(void)start;


@end

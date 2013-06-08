//
//  MasterViewController.h
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

#import <UIKit/UIKit.h>
#import "NSString+URLEncoding.h"
#import "NSNumber+Message.h"

#define ACTION_QUERY  0             //查询操作
#define ACTION_REMOVE 1             //删除操作
#define ACTION_ADD    2             //添加操作
#define ACTION_MOD    3             //修改操作

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSURLConnectionDelegate>
{
    int action; //请求动作标识
    int deleteRowId;//删除行号
}

@property (strong, nonatomic) DetailViewController *detailViewController;
//保存数据列表
@property (nonatomic,strong) NSMutableArray* listData;

//接收从服务器返回数据。
@property (strong,nonatomic) NSMutableData *datas;

//重新加载表视图
-(void)reloadView:(NSDictionary*)res;

//开始请求Web Service
-(void)startRequest;


@end

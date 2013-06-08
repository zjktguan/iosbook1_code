//
//  ViewController.h
//  AppSetting
//
//  Created by 关东升 on 12-9-28.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController

//用户名
@property (weak, nonatomic) IBOutlet UILabel *username;
//密码
@property (weak, nonatomic) IBOutlet UILabel *password;
//每月是否清除缓存
@property (weak, nonatomic) IBOutlet UILabel *clearCache;
//每月流量限制
@property (weak, nonatomic) IBOutlet UILabel *flowmeter;
//服务器
@property (weak, nonatomic) IBOutlet UILabel *serverName;
//通知-声音
@property (weak, nonatomic) IBOutlet UILabel *notiSound;
//通知-震动
@property (weak, nonatomic) IBOutlet UILabel *notiVibrate;


//读取设置数据
- (IBAction)getData:(id)sender;
@end

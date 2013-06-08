//
//  ViewController.h
//  RefreshControlSample
//
//  Created by 关东升 on 12-9-14.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>


@interface ViewController : UITableViewController <SKProductsRequestDelegate,SKPaymentTransactionObserver>

//点击刷新按钮
- (IBAction)request:(id)sender;
//点击恢复按钮
- (IBAction)restore:(id)sender;

//刷新按钮属性
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
//恢复按钮属性
@property (weak, nonatomic) IBOutlet UIBarButtonItem *restoreButton;
//产品列表
@property (nonatomic,strong) NSArray* skProducts;
//数字格式
@property (nonatomic,strong) NSNumberFormatter * priceFormatter;
//产品标识集合
@property (nonatomic,strong) NSSet * productIdentifiers;

@end

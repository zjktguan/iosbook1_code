//
//  ViewController.h
//  AdMobFullScreen2Demo
//
//  Created by 关东升 on 12-11-15.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <UIKit/UIKit.h>
#import "GADInterstitial.h"
#import <AdSupport/ASIdentifierManager.h>


#define INTERSTITIAL_AD_UNIT_ID @"a14df1974738141"

@interface ViewController : UIViewController <GADInterstitialDelegate>
{
    NSTimer *timer;        //用于模拟控制游戏进度
}

//进度条
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
//插页广告GADInterstitial对象属性
@property(nonatomic, strong) GADInterstitial *interstitial;
//画面中的按钮
@property (weak, nonatomic) IBOutlet UIButton *startButton;
//创建广告请求对象
- (GADRequest *)createRequest;
//更新进度条
-(void)update;
//按钮事件
- (IBAction)start:(id)sender;

@end
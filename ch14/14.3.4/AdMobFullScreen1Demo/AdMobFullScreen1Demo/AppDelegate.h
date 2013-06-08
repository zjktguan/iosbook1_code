//
//  AppDelegate.h
//  AdMobFullScreen1Demo
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

@interface AppDelegate : UIResponder <UIApplicationDelegate,GADInterstitialDelegate>


@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, strong) GADInterstitial *splashInterstitial;

- (GADRequest *)createRequest;

@end

//
//  AppDelegate.m
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

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef DEBUG
    // iOS6输出IDFA  iOS < 6输出UDID
    if (NSClassFromString(@"ASIdentifierManager")) {
        NSLog(@"GoogleAdMobAdsSDK ID for testing: %@" ,
              [[[ASIdentifierManager sharedManager]
                advertisingIdentifier] UUIDString]);
    } else {
        NSLog(@"GoogleAdMobAdsSDK ID for testing: %@" ,
              [[UIDevice currentDevice] uniqueIdentifier]);
    }
#endif
    
    self.splashInterstitial = [[GADInterstitial alloc] init];
    
    self.splashInterstitial.adUnitID =  INTERSTITIAL_AD_UNIT_ID;
    self.splashInterstitial.delegate = self;
    
    [self.splashInterstitial loadAndDisplayRequest:[self createRequest]
                                   usingWindow:self.window
                                  initialImage:[UIImage imageNamed:@"Splash.png"]];
    
    return YES;
}


#pragma mark GADRequest generation
// 创建广告请求
- (GADRequest *)createRequest {
    GADRequest *request = [GADRequest request];
    
#ifdef DEBUG
    //设置测试设备，防止测试阶段的无效请求，
    request.testDevices = [NSArray arrayWithObjects:
                           @"B88300B2-E817-46F9-803E-80AE4AC11A20", nil];
#endif
    
    return request;
}

#pragma mark GADInterstitialDelegate实现
- (void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"广告接收失败 %@", [error localizedDescription]);
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

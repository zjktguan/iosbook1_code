//
//  AppDelegate.m
//  KVOSample
//
//  Created by 关东升 on 12-8-31.
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
    
    self.watcher = [AppStatusWatcher new];
    
    [self addObserver:self.watcher forKeyPath:@"appStatus"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"Pass Context"];
    
    self.appStatus = @"launch";
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
    self.appStatus = @"inactive";

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    self.appStatus = @"background";
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    self.appStatus = @"inactive";

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    self.appStatus = @"active";
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    self.appStatus = @"terminate";
}

@end

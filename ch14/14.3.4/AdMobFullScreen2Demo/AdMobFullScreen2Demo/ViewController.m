//
//  ViewController.m
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

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)start:(id)sender {
    self.startButton.enabled = NO;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                    target:self
                                  selector:@selector(update)
                                  userInfo:nil
                                   repeats:YES];    

}

-(void)update
{
    self.progressView.progress += 0.1;
    if (self.progressView.progress == 1.0) {
        //游戏结束
        NSLog(@"游戏结束");
        [timer invalidate];
        timer = nil;
        
        //初始化广告
        self.interstitial = [[GADInterstitial alloc] init];
        
        self.interstitial.adUnitID =  INTERSTITIAL_AD_UNIT_ID;
        self.interstitial.delegate = self;
        [self.interstitial loadRequest:[self createRequest]];
    }
}


#pragma mark GADRequest generation
// 创建广告请求
- (GADRequest *)createRequest {
    GADRequest *request = [GADRequest request];
    
#ifdef DEBUG
    //设置测试设备，防止测试阶段的无效请求，
    request.testDevices = [NSArray arrayWithObjects:
                           @"D7860200-23DD-4CEF-9BE6-0702966DF94A", nil];
#endif
    
    return request;
}

#pragma mark GADInterstitialDelegate实现
- (void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"广告接收失败 %@", [error localizedDescription]);
    
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    NSLog(@"广告接收成功");
    [self.interstitial presentFromRootViewController:self];
    self.startButton.enabled = YES;
    self.progressView.progress = 0.0;
}

@end

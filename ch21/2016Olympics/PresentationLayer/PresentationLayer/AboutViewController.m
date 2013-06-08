//
//  AboutViewController.m
//  2016Olympics
//
//  Created by 关东升 on 12-11-24.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    //设定广告栏屏幕尺寸，实例化GADBannerView，
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    //设置应用发布者ID
    self.bannerView.adUnitID = kSampleAdUnitID;
    //设置委托
    self.bannerView.delegate = self;
    //设置广告栏的根视图控制器
    [self.bannerView setRootViewController:self];
    //竖屏情况下设置广告栏的位置
    self.bannerView.center = CGPointMake(self.view.center.x, kGADAdSizeBanner.size.height /2);
    [self.view addSubview:self.bannerView];
    //请求加载广告
    [self.bannerView loadRequest:[self createRequest]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


// 创建广告请求
- (GADRequest *)createRequest {
    GADRequest *request = [GADRequest request];
    return request;
}


#pragma mark GbannerViewViewDelegate实现

//广告接收成功
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"广告接收成功");
}
//广告接收失败
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"广告接收失败 %@", [error localizedFailureReason]);
    //重新请求加载广告
    [self.bannerView loadRequest:[self createRequest]];
}

@end

//
//  ViewController.m
//  iADFullScreen2Demo
//
//  Created by 关东升 on 12-11-14.
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
    
    self.page1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple-1.jpg"]];
    self.page1.frame = CGRectMake(0.0f, 0.0f, 1024.0f, 704.0f);
    [self.view addSubview:self.page1];
    
    self.page2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple-2.jpg"]];
    self.page2.frame = CGRectMake(0.0f, 0.0f, 1024.0f, 704.0f);
    
    self.interstitial = [[ADInterstitialAd alloc] init];
    self.interstitial.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchView:(id)sender {
    
    [UIView animateWithDuration:1.0 animations:^{
        if ([self.page1 superview]) {
            [self.page1 removeFromSuperview];
            [self.view addSubview:self.page2];
        } else {
            [self.page2 removeFromSuperview];
            [self.view addSubview:self.page1];
        }
    } completion:^(BOOL finished) {
        if (self.interstitial.loaded) {
            [self.interstitial presentFromViewController:self];
        }
    }];
}

#pragma mark ADInterstitialViewDelegate methods

// ADInterstitialAd对象卸载时候调用该方法
- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd
{
    NSLog(@"广告卸载");
    self.interstitial.delegate = nil;
    self.interstitial = [[ADInterstitialAd alloc] init];
    self.interstitial.delegate = self;
}

// 一个新的广告被加载每次都会调用该方法
- (void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd
{
    NSLog(@"广告加载成功");        
}

// 获得广告内容出错时候调用该方法
- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    NSLog(@"广告加载失败");
}

// 执行一个广告动作执行调用，返回YES可以执行动作，NO不可以执行
- (BOOL)interstitialAdActionShouldBegin:(ADInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

// 用户关闭模态广告窗口回调该方法
- (void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd
{
    NSLog(@"广告关闭");    
    self.interstitial.delegate = nil;
    self.interstitial = [[ADInterstitialAd alloc] init];
    self.interstitial.delegate = self;
}

@end

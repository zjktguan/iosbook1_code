//
//  ViewController.m
//  PageControlNavgation
//
//  Created by 关东升 on 12-9-18.
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
    
    self.pageControl.numberOfPages = 4;
    
    self.scrollView.frame = self.view.frame;
    
    self.scrollView.delegate = self;
    
	self.scrollView.contentSize = CGSizeMake(4 * 320.0f, 420.0f);
    
    self.page1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal-1.png"]];
    self.page1.frame = CGRectMake(0.0f, 0.0f, 320.0f, 420.0f);
    [self.scrollView addSubview:self.page1];
    
    self.page2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal-2.png"]];
    self.page2.frame = CGRectMake(320.0f, 0.0f, 320.0f, 420.0f);
    [self.scrollView addSubview:self.page2];
    
    self.page3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal-3.png"]];
    self.page3.frame = CGRectMake(320.0f * 2, 0.0f, 320.0f, 420.0f);
    [self.scrollView addSubview:self.page3];
    
    self.page4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal-4.png"]];
    self.page4.frame = CGRectMake(320.0f * 3, 0.0f, 320.0f, 420.0f);
    [self.scrollView addSubview:self.page4];
    
    //设定广告栏屏幕尺寸，实例化GADBannerView，
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    //设置应用发布者ID
    self.bannerView.adUnitID = kSampleAdUnitID;
    //设置委托
    self.bannerView.delegate = self;
    //设置广告栏的根视图控制器
    [self.bannerView setRootViewController:self];
    
    [self.view addSubview:self.bannerView];
    //请求加载广告
    [self.bannerView loadRequest:[self createRequest]];
    
}

- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
	CGPoint offset = aScrollView.contentOffset;
	self.pageControl.currentPage = offset.x / 320.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
#endif

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


- (void)viewDidLayoutSubviews
{
    
    CGRect contentFrame = self.view.bounds;
    if (contentFrame.size.width < contentFrame.size.height) {
        //竖屏情况下设置广告栏的位置
        self.bannerView.center = CGPointMake(self.view.center.x, kGADAdSizeBanner.size.height /2);
    } else {
        //横屏情况下设置广告栏的位置
        self.bannerView.center = CGPointMake(contentFrame.size.width / 2 , kGADAdSizeBanner.size.height / 2);
    }
    
}

// 创建广告请求
- (GADRequest *)createRequest {
    GADRequest *request = [GADRequest request];
    
    //设定性别
    request.gender = kGADGenderMale;
    //设置出生年月日
    [request setBirthdayWithMonth:12 day:7 year:1973];
    //设置位置信息
    [request setLocationWithLatitude:39.904667
                           longitude:116.408198
                            accuracy:1000];
    //设置位置描述信息
    [request setLocationWithDescription:@"美食城"];
    
    
#ifdef DEBUG
    //设置测试设备，防止测试阶段的无效请求，
    request.testDevices = [NSArray arrayWithObjects:
                           @"5F6A1B6D-6283-4BDF-A368-1EAA17F5DE78", nil];
#endif
    
    return request;
}



#pragma mark -
#pragma mark PageControl stuff
- (IBAction)changePage:(id)sender
{
    [UIView animateWithDuration:0.3f animations:^{
        int whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(320.0f * whichPage, 0.0f);
    }];
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

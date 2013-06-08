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
    
    
    // iOS 6 ADBannerView 实例化采用方法initWithAdType:
    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        self.bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        // 设定iOS 6 广告栏自动调整宽度
        self.bannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    } else {
        self.bannerView = [[ADBannerView alloc] init];
    }
    self.bannerView.delegate = self;
    
    [self.view insertSubview:self.bannerView aboveSubview:self.scrollView];
    
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

- (void)layoutAnimated:(BOOL)animated
{
    // 在iOS 6.0 广告栏是自动调整
    // 为了支持iOS 5.0 及以下版本，还需要设定currentContentSizeIdentifier
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
    CGRect contentFrame = self.view.bounds;
    if (contentFrame.size.width < contentFrame.size.height) {
        self.bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    } else {
        self.bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    }
#endif
    
    CGRect bannerFrame = _bannerView.frame;
    if (self.bannerView.bannerLoaded) {
       //设置在屏幕上边。 
        bannerFrame.origin.y = 0;
    } else {
        //设置在屏幕之外，使之隐藏起来。
        bannerFrame.origin.y -= self.bannerView.frame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        self.bannerView.frame = bannerFrame;
    }];
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
    [self layoutAnimated:[UIView areAnimationsEnabled]];
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

#pragma mark -
#pragma mark ADBannerViewDelegate方法
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"广告加载成功");
    [self layoutAnimated:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"广告加载失败");
    [self layoutAnimated:YES];
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    
    NSLog(@"广告关闭");
    [self layoutAnimated:YES];
}


@end

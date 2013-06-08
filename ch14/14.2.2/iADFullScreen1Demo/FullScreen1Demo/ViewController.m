//
//  ViewController.m
//  FullScreen1Demo
//
//  Created by 关东升 on 12-11-13.
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
    
    self.interstitial = [[ADInterstitialAd alloc] init];
    self.interstitial.delegate = self;
    
    self.scrollView.delegate = self;
    
    self.pageList = [[NSMutableArray alloc] init];
    [self.pageList addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple-1.jpg"]]];
    [self.pageList addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple-2.jpg"]]];
    [self.pageList addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple-3.jpg"]]];

    [self reloadPage];
    
    
}

//重新加载画面中的视图
-(void)reloadPage
{
    //内容视图高度
    int contentHeight = self.scrollView.frame.size.height;
    
    self.pageControl.numberOfPages = [self.pageList count];
    
    self.scrollView.contentSize = CGSizeMake([self.pageList count] * S_WIDTH, contentHeight);
    
    for (int i = 0; i< [self.pageList count]; i++) {
        UIView *view  = self.pageList[i];
        [view removeFromSuperview];
        view.frame = CGRectMake(S_WIDTH * i, 0.0f, S_WIDTH, contentHeight);
        [self.scrollView addSubview:view];
    }
}


- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
	CGPoint offset = aScrollView.contentOffset;
	self.pageControl.currentPage = 0.5 + offset.x / aScrollView.bounds.size.width;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark -
#pragma mark PageControl stuff
- (IBAction)changePage:(id)sender
{
    [UIView animateWithDuration:0.3f animations:^{
        int whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(S_WIDTH * whichPage, 0.0f);
    }];
}

#pragma mark ADInterstitialAdDelegate methods

// 一个新的广告被加载每次都会调用该方法
- (void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd
{
    NSLog(@"广告加载成功");
    
    UIView* interstitialContainer = [[UIView alloc] initWithFrame:CGRectZero];
    [self.pageList insertObject:interstitialContainer  atIndex:self.pageControl.currentPage];
    [self reloadPage];
    [self.interstitial presentInView:interstitialContainer];
    
}

// ADInterstitialAd对象卸载时候调用该方法
- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd
{
    NSLog(@"广告卸载");
    for (UIView* item in self.pageList) {
        if ([item isMemberOfClass:[UIView class]]) {
            [item removeFromSuperview];
            [self.pageList removeObject:item];
            [self reloadPage];
            break;
        }
    }
    
}


// 执行一个广告动作执行调用，返回YES可以执行动作，NO不可以执行
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
}
@end

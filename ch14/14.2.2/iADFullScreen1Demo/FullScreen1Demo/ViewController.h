//
//  ViewController.h
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

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

#define S_WIDTH 1024           //屏幕宽度
#define S_HEIGHT 768           //屏幕高度

@interface ViewController : UIViewController <UIScrollViewDelegate, ADInterstitialAdDelegate>

@property (strong, nonatomic) NSMutableArray *pageList;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) ADInterstitialAd *interstitial;


- (IBAction)changePage:(id)sender;

@end

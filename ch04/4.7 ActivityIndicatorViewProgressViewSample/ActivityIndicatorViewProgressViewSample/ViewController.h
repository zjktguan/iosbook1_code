//
//  ViewController.h
//  ActivityIndicatorViewProgressViewSample
//
//  Created by cherry on 12-9-7.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSTimer *myTimer;
}
@property(nonatomic,strong) NSTimer *myTimer;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicatorView;
@property (weak, nonatomic) IBOutlet UIProgressView *myProgressView;


- (IBAction)startToMove:(id)sender;
- (IBAction)downloadProgress:(id)sender;



@end

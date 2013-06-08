//
//  ViewController.m
//  ScreenRotateSample
//
//  Created by 关东升 on 12-8-6.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "ViewController.h"
#import "LandscapeViewController.h"

#define deg2rad (M_PI/180.0)


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    LandscapeViewController *landscapeViewController = [[UIStoryboard
                                                         storyboardWithName:@"LandscapeStoryboard" bundle:NULL]
                                                        instantiateViewControllerWithIdentifier:@"LandscapeViewController"];

    self.mainLandscapeView = landscapeViewController.view;
    self.mainPortraitView = self.view;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)
        toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view=self.mainLandscapeView;
        self.view.transform=CGAffineTransformMakeRotation(deg2rad*(90));
        self.view.bounds=CGRectMake(0.0, 0.0, 460.0, 320.0);
    } else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view=self.mainLandscapeView;
        self.view.transform=CGAffineTransformMakeRotation(deg2rad*(-90));
        self.view.bounds=CGRectMake(0.0, 0.0, 460.0, 320.0);
    } else {
        self.view=self.mainPortraitView;
        self.view.transform=CGAffineTransformMakeRotation(deg2rad*(0));
        self.view.bounds=CGRectMake(0.0, 0.0, 320.0, 460.0);
    }
    
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];    
}


@end
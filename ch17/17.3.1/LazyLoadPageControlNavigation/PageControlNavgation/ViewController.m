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
    
    self.scrollView.contentSize  = CGSizeMake(self.view.frame.size.width*4, self.scrollView.frame.size.height);
    self.scrollView.frame = self.view.frame;
    
    self.scrollView.delegate = self;
    
    self.page1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal-1.png"]];
    self.page1.frame = CGRectMake(0.0f, 0.0f, 320.0f, 420.0f);
    [self.scrollView addSubview:self.page1];
    
}


- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
	CGPoint offset = aScrollView.contentOffset;
	self.pageControl.currentPage = offset.x / 320.0f;
    
    [self loadImage:self.pageControl.currentPage + 1];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark PageControl stuff
- (IBAction)changePage:(id)sender
{
    [UIView animateWithDuration:0.3f animations:^{
        int whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(320.0f * whichPage, 0.0f);
        [self loadImage:self.pageControl.currentPage + 1];
    }];
}



-(void) loadImage:(int) nextPage
{
    
    if (nextPage == 1 && self.page2 == nil) {
        self.page2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal-2.png"]];
        self.page2.frame = CGRectMake(320.0f * nextPage, 0.0f, 320.0f, 420.0f);
        [self.scrollView addSubview:self.page2];
    }
    
    if (nextPage == 2 && self.page3 == nil) {
        self.page3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal-3.png"]];
        self.page3.frame = CGRectMake(320.0f * nextPage, 0.0f, 320.0f, 420.0f);
        [self.scrollView addSubview:self.page3];
    }
    
    if (nextPage == 3 && self.page4 == nil) {
        self.page4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal-4.png"]];
        self.page4.frame = CGRectMake(320.0f * nextPage, 0.0f, 320.0f, 420.0f);
        [self.scrollView addSubview:self.page4];
    }
    
}



@end

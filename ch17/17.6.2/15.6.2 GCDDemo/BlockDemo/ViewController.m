//
//  ViewController.m
//  GCDDemo
//
//  Created by 关东升 on 12-11-10.
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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    
    NSURL *imgkURL = [NSURL URLWithString:@"http://www.51work6.com/ios_book/animals/animal-3.png"];
    dispatch_queue_t downloadQueue = dispatch_queue_create("com.51wor6.image.downloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:imgkURL];
        UIImage *img = [UIImage imageWithData:imgData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = img;
        });
    });
    
}

@end

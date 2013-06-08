//
//  ViewController.m
//  NSThreadTest
//
//  Created by 关东升 on 12-11-9.
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


- (IBAction)testNSThread:(id)sender {
      [NSThread detachNewThreadSelector:@selector(calculationThreadEntry)
                                 toTarget:self withObject:nil];
}

- (IBAction)testGCD:(id)sender {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    size_t numberOfIterations = 100;
    dispatch_async(queue, ^(void) { dispatch_apply(numberOfIterations, queue, ^(size_t iteration){
        [self doCalculation];
        });
    });
}


- (void) doCalculation
{
    NSLog(@"%@", [NSDate date]);
}

- (void) calculationThreadEntry
{
    @autoreleasepool {
        NSUInteger counter = 0;
        while ([[NSThread currentThread] isCancelled] == NO)
        {
            [self doCalculation]; counter++;
            if (counter >= 100)
            {
                break;
            }
        }
    }
}

@end

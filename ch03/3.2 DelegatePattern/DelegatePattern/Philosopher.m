//
// Philosopher.m
//  DelegatePattern
//
//  Created by 关东升 on 12-8-28.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "Philosopher.h"

@implementation Philosopher

@synthesize delegate;

-(void) start
{
    count= 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(handle)userInfo:nil repeats:YES]; 
}

-(void)handle
{
    switch (count)
    {
        case 0:
            [self.delegate sleep];
            count++;
            break;
        case 1:
            [self.delegate eat];
            count++;
            break;
        case 2:
            [self.delegate work];
            [timer  invalidate];
            break;
    }
}

@end

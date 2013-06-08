//
//  CountDownViewController.m
//  2016Olympics
//
//  Created by 关东升 on 12-11-26.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "CountDownViewController.h"

@interface CountDownViewController ()

@end

@implementation CountDownViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	 
    //创建NSDateComponents对象
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //设置NSDateComponents日期
    [comps setDay:5];
    //设置NSDateComponents月
    [comps setMonth:8];
    //设置NSDateComponents年
    [comps setYear:2016];
    //创建日历对象
    NSCalendar *calender = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    //获得2016-8-5日的NSDate日期对象
    NSDate *destinationDate = [calender dateFromComponents:comps];
    //获得当前日期到2016-8-5时间的NSDateComponents对象
    NSDateComponents *components = [calender components:NSDayCalendarUnit
                                               fromDate:[NSDate date] toDate:destinationDate options:0];
    //获得当前日期到2016-8-5相差的天数
    int days = [components day];
    
    self.lblOnesPlace.text = [NSString stringWithFormat:@"%i",(days / 10)];
    self.lblTensPlace.text = [NSString stringWithFormat:@"%i",(days % 100 /10)];    
    self.lblHundredsPlace.text = [NSString stringWithFormat:@"%i",(days % 1000 /100)];
    self.lblThousandsPlace.text = [NSString stringWithFormat:@"%i",(days % 10000 /1000)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

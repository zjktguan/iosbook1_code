//
//  ScheduleViewController_iPhone.m
//  2016Olympics
//
//  Created by 关东升 on 12-11-23.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "ScheduleViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.data == nil || [self.data count] == 0) {
        ScheduleBL *bl = [ScheduleBL new];
        self.data = [bl readData];
        NSArray* keys = [self.data allKeys];
        //对key进行排序
        self.arrayGameDateList = [keys sortedArrayUsingSelector:@selector(compare:)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray* keys = [self.data allKeys];
    
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 

    //比赛日期
    NSString* strGameDate = [self.arrayGameDateList objectAtIndex:section];
    //比赛日期下的比赛日程表
    NSArray *schedules = [self.data objectForKey:strGameDate];
    
    return [schedules count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{   
    //比赛日期
    NSString* strGameDate = [self.arrayGameDateList objectAtIndex:section];
    
    return strGameDate;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    //比赛日期
    NSString* strGameDate = [self.arrayGameDateList objectAtIndex:indexPath.section];
    //比赛日期下的比赛日程表
    NSArray *schedules = [self.data objectForKey:strGameDate];
    
    Schedule *schedule = [schedules objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString* subtitle = [[NSString alloc] initWithFormat:@"%@ | %@", schedule.GameInfo, schedule.Event.EventName];
    
    cell.textLabel.text = schedule.GameTime;
    cell.detailTextLabel.text = subtitle;
    
    return cell;
}


-(NSArray *) sectionIndexTitlesForTableView: (UITableView *) tableView
{
    NSMutableArray *listTitles = [[NSMutableArray alloc] init];
    // 2016-08-09 -> 08-09
    for (NSString *item in self.arrayGameDateList) {
        NSString *title = [item substringFromIndex:5];
        [listTitles  addObject:title];
    }
    return listTitles;
}


@end

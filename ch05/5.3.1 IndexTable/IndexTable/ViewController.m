//
//  ViewController.m
//  IndexTable
//
//  Created by 关东升 on 12-9-12.
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
    
    NSBundle *bundle = [NSBundle mainBundle];
	NSString *plistPath = [bundle pathForResource:@"team_dictionary"
                                           ofType:@"plist"];
    //获取属性列表文件中的全部数据
	self.dictData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray* tempList  = [self.dictData allKeys];
    //对key进行排序
    self.listGroupname = [tempList sortedArrayUsingSelector:@selector(compare:)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark --UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //按照节索引从小组名数组中获得组名
    NSString *groupName = [self.listGroupname objectAtIndex:section];
    //按照组名做为key，从字典中取出球队数组集合
	NSArray *listTeams = [self.dictData objectForKey:groupName];
	return [listTeams count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.listGroupname count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *groupName = [self.listGroupname objectAtIndex:section];
	return groupName;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //获得选择的节
    NSUInteger section = [indexPath section];
    //获得选择节中的，选中的行索引
	NSUInteger row = [indexPath row];
    //按照节索引从小组名数组中获得组名
    NSString *groupName = [self.listGroupname objectAtIndex:section];
    //按照组名做为key，从字典中取出球队数组集合
	NSArray *listTeams = [self.dictData objectForKey:groupName];
    
    cell.textLabel.text =  [listTeams objectAtIndex:row];
    
    return cell;
}

-(NSArray *) sectionIndexTitlesForTableView: (UITableView *) tableView
{
    NSMutableArray *listTitles = [[NSMutableArray alloc] initWithCapacity:[self.listGroupname count]];
    //把 A组 -> A
    for (NSString *item in self.listGroupname) {
        NSString *title = [item  substringToIndex:1];
        [listTitles  addObject:title];
    }
    return listTitles;
}


@end

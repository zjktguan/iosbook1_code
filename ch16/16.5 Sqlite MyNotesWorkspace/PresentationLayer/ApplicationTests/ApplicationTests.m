//
//  ApplicationTests.m
//  ApplicationTests
//
//  Created by 关东升 on 12-10-26.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "ApplicationTests.h"

@implementation ApplicationTests

- (void)setUp
{
    [super setUp];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    UIWindow *window = [appDelegate window];
    
    UINavigationController *navController = (UINavigationController*)window.rootViewController;
    self.masterViewController  = (MasterViewController*)navController.topViewController;

    //准备测试数据
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //插入测试数据 cdate=2000-06-03 08:20:38 , content=welcome www.51work6.com
    NSString *theContent = @"welcome www.51work6.com";
    NSDate* theDate = [dateFormatter dateFromString:@"2000-06-03 08:20:38"];
    //创建Note对象
    Note *note = [[Note alloc] init];
    note.date  = theDate;
    note.content = theContent;    
    [[NoteDAO sharedManager] create:note];
    
    //插入测试数据 cdate=2001-06-03 08:20:38 , content=www.51work6.com
    theContent = @"www.51work6.com";
    theDate = [dateFormatter dateFromString:@"2001-06-03 08:20:38"];
    //创建Note对象
    note = [[Note alloc] init];
    note.date  = theDate;
    note.content = theContent;
    [[NoteDAO sharedManager] create:note];
    
}

- (void)tearDown
{
    [super tearDown];
    
    //删除测试数据
    NSArray* list =  [[NoteDAO sharedManager]  findAll];
    for (Note* note in list) {
        [[NoteDAO sharedManager]  remove:note];
    }
}

- (void)testInitViewController
{
    //断言 MasterViewController非空
    STAssertNotNil(self.masterViewController, @"MasterViewController非空");
    //断言 MasterViewController中listData属性非空
    STAssertNotNil(self.masterViewController.listData, @"MasterViewController中listData属性非空");
    //断言 MasterViewController中bl属性非空
    STAssertNotNil(self.masterViewController.bl, @"MasterViewController中bl属性非空");
}



- (void)testMasterViewControllerReturnsCorrectNumberOfRows
{
    [self.masterViewController.tableView reloadData];
    //断言 表视图返回行数为2
	STAssertEquals(2, [self.masterViewController tableView:nil numberOfRowsInSection:0], @"应该返回行数为2");
}

- (void)testMasterViewControllerTableViewCanEditRowAtIndexPath
{
    //断言 表视图返回行数为2
	STAssertTrue([self.masterViewController tableView:nil canEditRowAtIndexPath:nil], @"应该返回True");
}


- (void)testMasterViewControllerReturnsTableViewCell
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	
	UITableViewCell *cell = [self.masterViewController tableView:self.masterViewController.tableView cellForRowAtIndexPath:indexPath];
	//断言 单元格应该返回非空
	STAssertNotNil(cell, @"单元格应该返回非空");
    //断言 标签为非空
	STAssertEqualObjects(@"welcome www.51work6.com", cell.textLabel.text, @"标签为非空");

}

- (void)testPrepareForSegue
{
    
    id mockDetailViewController = [OCMockObject mockForClass:[DetailViewController class]];
    id mockStoryboardSegue = [OCMockObject mockForClass:[UIStoryboardSegue class]];
    
    [[[mockStoryboardSegue stub] andReturn:@"showDetail"] identifier];
    [[[mockStoryboardSegue stub] andReturn:mockDetailViewController] destinationViewController];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    Note  *note = self.masterViewController.listData[indexPath.row];
    [[mockDetailViewController expect] setDetailItem:note];
    
    [self.masterViewController.tableView selectRowAtIndexPath:indexPath animated:NO
                                               scrollPosition:UITableViewScrollPositionNone];
    
    [self.masterViewController prepareForSegue:mockStoryboardSegue sender:OCMOCK_ANY];
    //验证
    [mockStoryboardSegue verify];
    [mockDetailViewController verify];
    
}



@end

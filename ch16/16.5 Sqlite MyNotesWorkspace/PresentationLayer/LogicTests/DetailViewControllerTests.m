//
//  DetailViewControllerTests.m
//  DetailViewControllerTests
//
//  Created by 关东升 on 12-10-22.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <GHUnitIOS/GHUnit.h>
#import <OCMock/OCMock.h>
#import "DetailViewController.h"
#import "NoteDAO.h"
#import "Note.h"


@interface DetailViewControllerTests : GHTestCase {
    
}

@property (nonatomic,strong) NSDateFormatter * dateFormatter;

@property (nonatomic,strong) NSString* theContent;
@property (nonatomic,strong) NSDate* theDate;

@end

@implementation DetailViewControllerTests

- (void)setUpClass {
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    self.theContent = @"welcome www.51work6.com";
    self.theDate = [self.dateFormatter dateFromString:@"2000-06-03 08:20:38"];
}

- (void)tearDownClass {
    self.dateFormatter = nil;
self.theContent= nil;
    self.theDate= nil;
}

- (void)setUp { }

- (void)tearDown { }


//测试 setDetailItem方法
-(void) testSetDetailItem
{
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    
    id mockDetailDescriptionLabel = [OCMockObject mockForClass:[UILabel class]];
    
    detailViewController.detailDescriptionLabel = mockDetailDescriptionLabel;
    
    [[[mockDetailDescriptionLabel stub] andReturn:self.theContent] text];
    
    //创建Note对象
    Note *note = [[Note alloc] init];
    note.date  = self.theDate;
    note.content = self.theContent;
    
    [[mockDetailDescriptionLabel expect] setText:self.theContent];
    
    [detailViewController setDetailItem:note];
    //验证
    [mockDetailDescriptionLabel verify];
}

@end
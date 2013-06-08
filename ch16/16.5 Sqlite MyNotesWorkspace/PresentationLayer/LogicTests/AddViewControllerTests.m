//
//  AddViewControllerTests.m
//  AddViewControllerTests
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
#import "AddViewController.h"
#import "NoteDAO.h"
#import "Note.h"


@interface AddViewControllerTests : GHTestCase {
    
}

@property (nonatomic,strong) NSDateFormatter * dateFormatter;

@property (nonatomic,strong) NSString* theContent;
@property (nonatomic,strong) NSDate* theDate;

@end

@implementation AddViewControllerTests

- (void)setUpClass {
    
}

- (void)tearDownClass {

}

- (void)setUp {
}

- (void)tearDown {
}


//测试 onclickSave方法
-(void) testOnclickSave
{
    
    AddViewController *addViewController = [[AddViewController alloc] init];
    
    id mockTextView = [OCMockObject mockForClass:[UITextView class]];
    addViewController.txtView = mockTextView;    
    [[[mockTextView stub] andReturn:@"welcome www.51work6.com"] text];
    [[mockTextView expect] resignFirstResponder];
    
    //测试 通知
    id mock = [OCMockObject observerMock];
    [[NSNotificationCenter defaultCenter] addMockObserver:mock
                                                     name:@"reloadViewNotification"
                                                   object:nil];

    [[mock expect] notificationWithName:@"reloadViewNotification" object:OCMOCK_ANY userInfo:OCMOCK_ANY];
    
    [addViewController onclickSave:OCMOCK_ANY];
    
    //验证
    [mockTextView verify];
    [mock verify];
    
    [[NSNotificationCenter defaultCenter] removeObserver:mock];
}


-(void)testTextView
{
    AddViewController *addViewController = [[AddViewController alloc] init];
    id mockTextView = [OCMockObject mockForClass:[UITextView class]];

    [[mockTextView expect] resignFirstResponder];
    BOOL res = [addViewController textView:mockTextView shouldChangeTextInRange:NSMakeRange(0,0) replacementText:@"\n"];
    
    GHAssertFalse(res,@"输入回车符号");
    
    [mockTextView verify];
}


@end
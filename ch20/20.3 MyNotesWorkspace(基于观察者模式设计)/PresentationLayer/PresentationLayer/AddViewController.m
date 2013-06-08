//
//  AddViewController.m
//  MyNotes
//
//  Created by 关东升 on 12-9-26.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

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
    
    _bl = [NoteBL new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createNoteFinished:)
                                                 name:BLCreateNoteFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createNoteFailed:)
                                                 name:BLCreateNoteFailedNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)onclickDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onclickSave:(id)sender {
    
    Note *note = [Note new];
    note.date = [[NSDate alloc] init];
    note.content = _textView.text;
    [_bl createNote: note];
}


//插入Note方法 成功
- (void)createNoteFinished:(NSNotification*)notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"操作信息"
                                                        message:@"插入成功。"
                                                       delegate:self
                                              cancelButtonTitle:@"返回"
                                              otherButtonTitles:@"继续", nil];
    [alertView show];
}

//插入Note方法 失败
- (void)createNoteFailed:(NSNotification*)notification
{
    NSError *error = [notification object];
    NSString *errorStr = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"操作信息"
                                                        message:errorStr
                                                       delegate:self
                                              cancelButtonTitle:@"返回"
                                              otherButtonTitles:@"继续", nil];
    [alertView show];
}


//响应对话框按钮事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//选择返回按钮
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



@end

//
//  DetailViewController.m
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

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    if (self.detailItem) {
        Note *note = _detailItem;
        _textView.text = note.content;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
        self.navigationItem.rightBarButtonItem = addButton;
    }
    
    
    _bl = [NoteBL new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifyNoteFinished:)
                                                 name:BLModifyFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifyNoteFailed:)
                                                 name:BLModifyFailedNotification
                                               object:nil];
}


- (void)insertNewObject:(id)sender
{
    
    AddViewController *modalViewController = [self.storyboard
                                              instantiateViewControllerWithIdentifier:@"addViewController"];
    
    modalViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    modalViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:modalViewController animated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)onclickSave:(id)sender {
    
    Note *note = _detailItem;
    note.date = [[NSDate alloc] init];
    note.content = _textView.text;
    [_bl modifyNote:note];
    
}

//插入Note方法 成功
- (void)modifyNoteFinished:(NSNotification*)notification {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"操作信息"
                                                        message:@"修改成功。"
                                                       delegate:self
                                              cancelButtonTitle:@"返回"
                                              otherButtonTitles:@"继续", nil];
    [alertView show];
}

//插入Note方法 失败
- (void)modifyNoteFailed:(NSNotification*)notification
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
        //返回
        UINavigationController *navController = (UINavigationController*)self.parentViewController;
        [navController popViewControllerAnimated:YES];
    }
}


@end

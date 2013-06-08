//
//  ViewController.m
//  ModalViewSample
//
//  Created by 关东升 on 12-9-24.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "ViewController.h"
#import "ModalViewController.h"

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

- (IBAction)onclick:(id)sender {
    
    ModalViewController *modalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"modalViewController"];
    
    modalViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    switch (self.segControl.selectedSegmentIndex) {
        case 0:
            modalViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            break;
        case 1:
            modalViewController.modalPresentationStyle = UIModalPresentationPageSheet;
            break;
        case 2:
            modalViewController.modalPresentationStyle = UIModalPresentationFormSheet;
            break;
        default:
            modalViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
            break;
    }
    
    [self presentViewController:modalViewController animated:YES completion:nil];
    
    
}
@end

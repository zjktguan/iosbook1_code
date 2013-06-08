//
//  ViewController.m
//  MVCSample_SB
//
//  Created by 关东升 on 12-9-1.
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
	// Do any additional setup after loading the view, typically from a nib.
    self.myTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMyButton:nil];
    [self setMyTextField:nil];
    [super viewDidUnload];
}

- (IBAction)myAction:(id)sender {
    
    NSLog(@"call myAction:");
    
}


#pragma mark -- UITextFieldDelegate method
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"call textFieldShouldBeginEditing:");
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"call textFieldDidBeginEditing:");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"call textFieldShouldEndEditing:");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"call textFieldDidEndEditing:");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"call textFieldShouldReturn:");
    [textField resignFirstResponder];
    return YES;
}


@end
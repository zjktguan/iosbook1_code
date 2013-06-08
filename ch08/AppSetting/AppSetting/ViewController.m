//
//  ViewController.m
//  AppSetting
//
//  Created by 关东升 on 12-9-28.
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
	
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getData:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)getData:(id)sender {
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];

    
    self.username.text = [defaults stringForKey:@"name_preference"];
    self.password.text = [defaults stringForKey:@"password_preference"];
    
    if ([defaults boolForKey:@"enabled_preference"]) {
        self.clearCache.text = @"YES";
    } else
    {
        self.clearCache.text = @"NO";
    }
    
    self.flowmeter.text = [NSString stringWithFormat:@"%.2fGB",[defaults doubleForKey:@"slider_preference"]];
    
    self.serverName.text = [defaults stringForKey:@"multivaule_preference"];
    
    if ([defaults boolForKey:@"sound_enabled_preference"]) {
        self.notiSound.text = @"YES";
    } else
    {
        self.notiSound.text = @"NO";
    }
    
    
    if ([defaults boolForKey:@"vibrate_enabled_preference"]) {
        self.notiVibrate.text = @"YES";
    } else
    {
        self.notiVibrate.text = @"NO";
    }
}


@end

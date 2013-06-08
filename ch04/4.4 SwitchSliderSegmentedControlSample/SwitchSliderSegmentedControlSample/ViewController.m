//
//  ViewController.m
//  SwitchSliderSegmentedControlSample
//
//  Created by cherry on 12-9-7.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


//使两个开关的值保持一致
- (IBAction)switchValueChanged:(id)sender {
    
    UISwitch *witchSwitch = (UISwitch *)sender;
    BOOL setting = witchSwitch.isOn;
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}


//点击分段控件控制开关控件的隐藏或显示
- (IBAction)touchDown:(id)sender {
    if (self.leftSwitch.hidden  == YES) {
        self.rightSwitch.hidden = NO;
        self.leftSwitch.hidden  = NO;
    }else{
        self.leftSwitch.hidden  = YES;
        self.rightSwitch.hidden = YES;
    }
}

//用标签显示滑块的值
- (IBAction)sliderValueChange:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int progressAsInt = (int)(slider.value + 0.5f);
    NSString *newText = [[NSString alloc]initWithFormat:@"%d",progressAsInt];
    self.SliderValue.text = newText;
}



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

@end

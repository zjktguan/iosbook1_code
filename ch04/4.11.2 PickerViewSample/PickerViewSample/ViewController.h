//
//  ViewController.h
//  PickerViewSample
//
//  Created by 关东升 on 12-8-7.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong)  NSDictionary  *pickerData; //保存全部数据
@property (nonatomic, strong)  NSArray  *pickerProvincesData;//当前的省数据
@property (nonatomic, strong)  NSArray  *pickerCitiesData;//当前的省下面的市数据


- (IBAction)onclick:(id)sender;

@end

//
//  ViewController.m
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

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSBundle *bundle = [NSBundle mainBundle];
	NSString *plistPath = [bundle pathForResource:@"provinces_cities"
                                           ofType:@"plist"];
    //获取属性列表文件中的全部数据
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
	self.pickerData = dict;
    
	//省份名数据
	self.pickerProvincesData =  [self.pickerData allKeys];
    
    //默认取出第一个省的所有市的数据
	NSString *seletedProvince = [self.pickerProvincesData objectAtIndex:0];
	self.pickerCitiesData = [self.pickerData objectForKey:seletedProvince];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onclick:(id)sender {

    NSInteger row1 = [self.pickerView selectedRowInComponent:0];
	NSInteger row2 = [self.pickerView selectedRowInComponent:1];
	NSString *selected1 = [self.pickerProvincesData objectAtIndex:row1];
	NSString *selected2 = [self.pickerCitiesData objectAtIndex:row2];
	
	NSString *title = [[NSString alloc] initWithFormat:@"%@，%@市",
					   selected1,selected2];
    
	self.label.text = title;
    
}



#pragma mark 实现协议UIPickerViewDataSource方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
        numberOfRowsInComponent:(NSInteger)component {
	if (component == 0) {//省份个数
		return [self.pickerProvincesData count];
	} else {//市的个数
		return [self.pickerCitiesData count];
	}
	
}

#pragma mark 实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView
			titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (component == 0) {//选择省份名
		return [self.pickerProvincesData objectAtIndex:row];
	} else {//选择市名
		return [self.pickerCitiesData objectAtIndex:row];
	}
}

- (void)pickerView:(UIPickerView *)pickerView
	  didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (component == 0) {
		NSString *seletedProvince = [self.pickerProvincesData objectAtIndex:row];
		NSArray *array = [self.pickerData objectForKey:seletedProvince];
		self.pickerCitiesData = array;
		[self.pickerView reloadComponent:1];
	}
}

@end

//
//  AddViewController.m
//  Write_Contacts
//
//  Created by 关东升 on 12-10-9.
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


- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)saveClick:(id)sender {
    

    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    ABRecordRef person = ABPersonCreate();

    //保存姓名
    ABRecordSetValue(person, kABPersonFirstNameProperty,
                     (__bridge CFTypeRef)self.txtFirstName.text, &error);
    ABRecordSetValue(person, kABPersonLastNameProperty,
                     (__bridge CFTypeRef)self.txtLastName.text, &error);
    
    // 设置电话号码
    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multi,  (__bridge CFTypeRef)self.txtMobile.text,
                                 kABPersonPhoneMobileLabel, NULL);
    ABMultiValueAddValueAndLabel(multi,  (__bridge CFTypeRef)self.txtIPhone.text,
                                 kABPersonPhoneIPhoneLabel, NULL);
    
    // 添加电话号码到记录
    ABRecordSetValue(person, kABPersonPhoneProperty, multi, &error);
    CFRelease(multi);

    // 设置Email属性
    multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multi,  (__bridge CFTypeRef)self.txtHomeEmail.text,
                                 kABHomeLabel, NULL);
    ABMultiValueAddValueAndLabel(multi,  (__bridge CFTypeRef)self.txtWorkEmail.text,
                                 kABWorkLabel, NULL);
    // 添加Email到记录
    ABRecordSetValue(person, kABPersonEmailProperty, multi, &error);
    CFRelease(multi);

    // 增加记录到数据库
    ABAddressBookAddRecord(addressBook, person, &error);
    // 保存到数据库
    ABAddressBookSave(addressBook, &error);
    CFRelease(person);
    CFRelease(addressBook);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

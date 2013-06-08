//
//  DetailViewController.m
//  Read_Contacts
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

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ABRecordID personID = [self.personIDAsNumber intValue];
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, personID);
    
    //取得姓名属性
    NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    firstName = firstName != nil?firstName:@"";
    NSString *lastName =  CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    lastName = lastName != nil?lastName:@"";
    [self.lblName setText: [NSString stringWithFormat:@"%@ %@",firstName,lastName]];
    
    //取得Email属性
    ABMultiValueRef emailsProperty = ABRecordCopyValue(person, kABPersonEmailProperty);
    NSArray* emailsArray = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(emailsProperty));
    for(int index = 0; index< [emailsArray count]; index++){
        NSString *email = [emailsArray objectAtIndex:index];
        NSString *emailLabel = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(emailsProperty, index));
        
        if ([emailLabel isEqualToString:(NSString*)kABWorkLabel]) {
            [self.txtWorkEmail setText:email];
        } else if ([emailLabel isEqualToString:(NSString*)kABHomeLabel]) {
            [self.txtHomeEmail setText:email];
        } else {
            NSLog(@"%@: %@", @"其它Email", email);
        }
    }
    CFRelease(emailsProperty);
    
    //取得电话号码属性
    ABMultiValueRef phoneNumberProperty = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSArray* phoneNumberArray = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phoneNumberProperty));
    for(int index = 0; index< [phoneNumberArray count]; index++){
        NSString *phoneNumber = [phoneNumberArray objectAtIndex:index];
        NSString *phoneNumberLabel = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phoneNumberProperty, index));
        
        if ([phoneNumberLabel isEqualToString:(NSString*)kABPersonPhoneMobileLabel]) {
            [self.txtMobile setText:phoneNumber];
        } else if ([phoneNumberLabel isEqualToString:(NSString*)kABPersonPhoneIPhoneLabel]) {
            [self.txtIPhone setText:phoneNumber];
        } else {
            NSLog(@"%@: %@", @"其它电话", phoneNumber);
        }
    }
    CFRelease(phoneNumberProperty);
    
    //取得个人图片
    if (ABPersonHasImageData(person)) {
        NSData *photoData = CFBridgingRelease(ABPersonCopyImageData(person));
        if(photoData){
            [self.imageView setImage:[UIImage imageWithData:photoData]];
        }
    }
    CFRelease(addressBook);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)saveClick:(id)sender {
    
    ABRecordID personID = [self.personIDAsNumber intValue];
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, personID);
    
    // 设置电话号码
    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multi,  (__bridge CFTypeRef)self.txtMobile.text,
                                 kABPersonPhoneMobileLabel, NULL);
    ABMultiValueAddValueAndLabel(multi,  (__bridge CFTypeRef)self.txtIPhone.text,
                                 kABPersonPhoneIPhoneLabel, NULL);
    
    // 添加电话号码到数据库
    ABRecordSetValue(person, kABPersonPhoneProperty, multi, &error);
    CFRelease(multi);
    
    // 设置Email属性
    multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multi,  (__bridge CFTypeRef)self.txtHomeEmail.text,
                                 kABHomeLabel, NULL);
    ABMultiValueAddValueAndLabel(multi,  (__bridge CFTypeRef)self.txtWorkEmail.text,
                                 kABWorkLabel, NULL);
    // 添加Email到数据库
    ABRecordSetValue(person, kABPersonEmailProperty, multi, &error);
    CFRelease(multi);

    // 保存到数据库
    ABAddressBookSave(addressBook, &error);
    CFRelease(addressBook);
    
    //导航回根视图控制器ViewController
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)deleteClick:(id)sender {
    ABRecordID personID = [self.personIDAsNumber intValue];
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, personID);
    
    //删除记录
    ABAddressBookRemoveRecord(addressBook,person,&error);
    // 保存到数据库
    ABAddressBookSave(addressBook, &error);
    CFRelease(addressBook);
    
    //导航回根视图控制器ViewController
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end

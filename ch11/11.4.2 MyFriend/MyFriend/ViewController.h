//
//  ViewController.h
//  MyFriend
//
//  Created by 关东升 on 12-10-11.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController : UITableViewController
    <ABPeoplePickerNavigationControllerDelegate,ABPersonViewControllerDelegate>

//保存联系人姓名数组属性
@property(nonatomic, retain) NSMutableArray *contactNames;
//保存联系人ID数组属性
@property(nonatomic, retain) NSMutableArray *contactIDs;

//选择联系人
- (IBAction)selectContacts:(id)sender;

@end

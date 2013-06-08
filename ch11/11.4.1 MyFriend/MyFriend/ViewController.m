//
//  ViewController.m
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

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!_contactNames) {
        _contactNames = [[NSMutableArray alloc] init];
    }
    
    if(!_contactIDs) {
        _contactIDs = [[NSMutableArray alloc] init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 表视图数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = [self.contactNames objectAtIndex:[indexPath row]];
	
    return cell;
}

#pragma mark -
#pragma mark ABPeoplePickerNavigationController 委托方法实现
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
	[peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
	  shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
	
	NSString *name = CFBridgingRelease(ABRecordCopyCompositeName(person));
    
	[self.contactNames addObject:name];
	[self.contactIDs addObject:[NSNumber numberWithInt:ABRecordGetRecordID(person)]];
    
	[peoplePicker dismissViewControllerAnimated:YES completion:nil];
	
    //取得最后一个放入contactIDs中的ID，也就是刚刚选择的ID
	NSIndexPath *path = [NSIndexPath indexPathForRow:self.contactIDs.count-1 inSection:0];
	//选中联系人插入到首页表视图中
	NSArray *arry = [NSArray arrayWithObject:path];
	[self.tableView insertRowsAtIndexPaths:arry withRowAnimation:UITableViewRowAnimationRight];
	
	return NO;
	
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
	  shouldContinueAfterSelectingPerson:(ABRecordRef)person
      property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
}

//选择联系人
- (IBAction)selectContacts:(id)sender
{
    ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    peoplePicker.peoplePickerDelegate = self;
//    peoplePicker.displayedProperties =
//        @[[NSNumber numberWithInt:kABPersonEmailProperty],[NSNumber numberWithInt:kABPersonPhoneProperty]];
    [self presentViewController:peoplePicker animated:YES completion:nil];
    
}


@end

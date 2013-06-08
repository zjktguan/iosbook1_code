//
//  MasterViewController.m
//  MyNotes
//
//  Created by 关东升 on 12-9-26.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@implementation MasterViewController


- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    //查询请求数据
    action = ACTION_QUERY;
    [self startRequest];
    
    //初始化UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    
}


-(void) refreshTableView
{
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
        
        //查询请求数据
        action = ACTION_QUERY;
        [self startRequest];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"  forIndexPath:indexPath];
    
    NSMutableDictionary*  dict = self.listData[indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"Content"];
    cell.detailTextLabel.text = [dict objectForKey:@"CDate"];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //删除数据
        action = ACTION_REMOVE;
        [self startRequest];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary*  dict = self.listData[indexPath.row];
        DetailViewController *detailViewController = [segue destinationViewController];
        [detailViewController setDetailItem:[dict objectForKey:@"ID"]];
        [detailViewController setDetailContent: [dict objectForKey:@"Content"]];
    }
}

/*
 * 开始请求Web Service
 */
-(void)startRequest
{
    
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://iosbook1.com/service/mynotes/webservice.php"];
    
	NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    NSString *post;
    if (action == ACTION_QUERY) {//查询处理
        post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@", @"<你的iosbook1.com用户邮箱>",@"JSON",@"query"];
    } else if (action == ACTION_REMOVE) {//删除处理
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary*  dict = self.listData[indexPath.row];
        post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&id=%@",
                @"<你的iosbook1.com用户邮箱>",@"JSON",@"remove",[dict objectForKey:@"ID"]];
    }
	
    NSData *postData  = [post dataUsingEncoding:NSUTF8StringEncoding];
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:postData];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request delegate:self];
	
    if (connection) {
        _datas = [NSMutableData new];
    }
}


#pragma mark- NSURLConnection 回调方法
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_datas appendData:data];
}


-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
    
    NSLog(@"%@",[error localizedDescription]);
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    NSLog(@"请求完成...");
    
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:_datas options:NSJSONReadingAllowFragments error:nil];
    
    if (action == ACTION_QUERY) {//查询处理
        [self reloadView:dict];
    } else if (action == ACTION_REMOVE) {//删除处理
        NSString *message = @"操作成功。";
        
        NSNumber *resultCodeObj = [dict objectForKey:@"ResultCode"];
        
        if ([resultCodeObj integerValue] < 0) {
            message = [resultCodeObj errorMessage];
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
        
        //重新查询
        action = ACTION_QUERY;
        [self startRequest];
    }
    
}


//重新加载表视图
-(void)reloadView:(NSDictionary*)res
{
    if (self.refreshControl) {
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSNumber *resultCodeObj = [res objectForKey:@"ResultCode"];
    if ([resultCodeObj integerValue] >=0)
    {
        self.listData = [res objectForKey:@"Record"];
        [self.tableView reloadData];
    } else {
        NSString *errorStr = [resultCodeObj errorMessage];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误信息"
                                                            message:errorStr
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
        
        
    }
    
    
}

@end

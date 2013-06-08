//
//  ViewController.m
//  RefreshControlSample
//
//  Created by 关东升 on 12-9-14.
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
    
    //设置数字格式
    self.priceFormatter = [[NSNumberFormatter alloc] init];
    [self.priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [self.priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    //从ProductIdentifiers.plist文件读取应用内产品标识
    NSString* path = [[NSBundle mainBundle] pathForResource:@"ProductIdentifiers" ofType:@"plist"];
    NSArray* array = [[NSArray alloc] initWithContentsOfFile:path];
    //从NSArray转化为NSSet
    self.productIdentifiers = [[NSSet alloc] initWithArray:array];
    
    // 添加self作为交易观察者对象
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)request:(id)sender {
    
    //检查设备是否有家长控制，禁止应用内购买
    if ([SKPaymentQueue canMakePayments]) {
        //没有设置可以请求应用购买信息
        SKProductsRequest *request= [[SKProductsRequest alloc]
                                     initWithProductIdentifiers:self.productIdentifiers];
        request.delegate = self;
        [request start];
        
        self.navigationItem.prompt = @"刷新中...";
        self.refreshButton.enabled = NO;
        self.restoreButton.enabled = NO;
        
    } else {
        //有设置情况下
        UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"访问限制"
                                                             message:@"您不能进行应用内购买！"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles: nil];
        [alertView show];
    }
}

- (IBAction)restore:(id)sender {
    self.navigationItem.prompt = @"恢复中...";
    self.refreshButton.enabled = NO;
    self.restoreButton.enabled = NO;
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}


#pragma mark -- SKProductsRequestDelegate协议实现方法
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"加载应用内购买产品...");
    
    self.navigationItem.prompt = nil;
    self.refreshButton.enabled = YES;
    self.restoreButton.enabled = YES;
    
    self.skProducts = response.products;
    for (SKProduct * skProduct in self.skProducts) {
        NSLog(@"找到产品: %@ %@ %0.2f",
              skProduct.productIdentifier,
              skProduct.localizedTitle,
              skProduct.price.floatValue);
    }
    
    [self.tableView reloadData];
}


#pragma mark---UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.skProducts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    int row = [indexPath row];
    SKProduct * product = self.skProducts[row];
    
	cell.textLabel.text = product.localizedTitle;
    
    [self.priceFormatter setLocale:product.priceLocale];
    cell.detailTextLabel.text = [self.priceFormatter stringFromNumber:product.price];
    
    //从应用设置文件中读取 购买信息
    BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:product.productIdentifier];
    if (productPurchased) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryView = nil;
    } else {
        UIImage *buttonUpImage = [UIImage imageNamed:@"button_up.png"];
		UIImage *buttonDownImage = [UIImage imageNamed:@"button_down.png"];
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0.0f, 0.0f, buttonUpImage.size.width, buttonUpImage.size.height);
		[button setBackgroundImage:buttonUpImage forState:UIControlStateNormal];
		[button setBackgroundImage:buttonDownImage forState:UIControlStateHighlighted];
		[button setTitle:@"购买" forState:UIControlStateNormal];
        button.tag = indexPath.row;
		[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
		
		cell.accessoryView = button;
        
    }
    return cell;
}

- (void)buttonTapped:(id)sender {
    
    UIButton *buyButton = (UIButton *)sender;
    //通过按钮tag获得被点击按钮的索引，使用索引从数组中取出产品SKProduct对象
    SKProduct *product = self.skProducts[buyButton.tag];
    //获得产品的付款对象
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    //把付款对象添加到付款队列中
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

#pragma mark SKPaymentTransactionObserver协议实现方法
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction * transaction in transactions) {
        switch (transaction.transactionState)
        {                
            case SKPaymentTransactionStatePurchased: //交易完成
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:    //交易失败
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:  //交易恢复
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
    
}

//交易完成
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"交易完成...");
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
    //把交易从付款队列中移除
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

//交易恢复
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"交易恢复...");
    
    self.navigationItem.prompt = nil;
    self.refreshButton.enabled = YES;
    self.restoreButton.enabled = YES;
    
    [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

//交易失败
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"交易失败...");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"交易失败: %@", transaction.error.localizedDescription);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//购买成功
- (void)provideContentForProductIdentifier:(NSString *)productIdentifier {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}

@end

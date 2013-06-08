//
//  ViewController.m
//  WebViewSample
//
//  Created by 关东升 on 12-9-4.
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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testLoadHTMLString:(id)sender {
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
	NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSError *error = nil;
    
	NSString *html = [[NSString alloc] initWithContentsOfFile:htmlPath encoding: NSUTF8StringEncoding error:&error];
    
    if (error == nil) {//数据加载没有错误情况下
        [self.webView loadHTMLString:html baseURL:bundleUrl];
    }
}

- (IBAction)testLoadData:(id)sender {
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
	NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSError *error = nil;
    
	NSData *htmlData = [[NSData alloc]  initWithContentsOfFile: htmlPath];
    
    if (error == nil) {//数据加载没有错误情况下
        [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8"baseURL: bundleUrl];
    }
}

- (IBAction)testLoadRequest:(id)sender {
    
	NSURL * url = [NSURL URLWithString: @"http://www.51work6.com"];
	NSURLRequest * request = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:request];
    self.webView.delegate = self;
}


#pragma mark -- UIWebViewDelegate委托定义方法
- (void)webViewDidFinishLoad: (UIWebView *) webView {
	NSLog(@"%@", [webView stringByEvaluatingJavaScriptFromString:
				  @"document.body.innerHTML"]);
}


@end

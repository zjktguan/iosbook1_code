//
//  HelloWorldViewController.m
//  MyPhoneGap
//
//  Created by 关东升 on 12-5-25.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//
//

#import "HelloWorldViewController.h"
#import "NSString+URLEncoding.h"

@interface HelloWorldViewController ()

@end

@implementation HelloWorldViewController

@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"www/index" ofType:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark –
#pragma mark UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"helloWorld('从iOS对象中调用JS Ok.')"];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *actionType = request.URL.host;
    NSString *scheme = request.URL.scheme;
    NSString *fragment = [request.URL.fragment URLDecodedString];
    NSData *responseData = [fragment dataUsingEncoding:NSUTF8StringEncoding];
    
    if ( [scheme isEqualToString:@"gap"] ) {
        if ([actionType isEqualToString:@"XXXClass.XXXmethod"]) {
            
            NSError* error;
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:responseData
                                  options:NSJSONReadingAllowFragments
                                  error:&error];
            
            NSLog(@"title: %@ , message: %@",[json objectForKey:@"title"], [json objectForKey:@"message"] );
            
        }
    }
    return true;
}

@end

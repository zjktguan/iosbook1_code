//
//  ViewController.m
//  PITax
//
//  Created by 关东升 on 12-10-22.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)onClick:(id)sender {
    //关闭键盘
    [self.txtRevenue resignFirstResponder];
    
    self.lblTax.text =[self calculate:self.txtRevenue.text];
}

//计算个人所得税
-(NSString*) calculate:(NSString*)revenue {
    
    //月应纳个人所得税税额
    double tax = 0.0f;
    
    if ([revenue length] > 0) {
        
        double dbRevenue = [revenue doubleValue];
        
        //月应纳税所得额
        double dbTaxRevenue = dbRevenue - 3500;
        
            //月应纳税所得额不超过1500元
        if (dbTaxRevenue <= 1500) {//失败 if (dbTaxRevenue >= 1500)
            tax = dbTaxRevenue * 0.03;
            //月应纳税所得额超过1500元至4500元
        } else if (dbTaxRevenue > 1500 && dbTaxRevenue <=4500) {
            tax = dbTaxRevenue * 0.1 - 105;
            //月应纳税所得额超过4500元至9000元
        } else if (dbTaxRevenue > 4500 && dbTaxRevenue <=9000) {
            tax = dbTaxRevenue * 0.2 - 555;
            //月应纳税所得额超过9000元至35000元
        } else if (dbTaxRevenue > 9000 && dbTaxRevenue <=35000) {
            tax = dbTaxRevenue * 0.25 - 1005;
            //月应纳税所得额超过35000元至55000元
        } else if (dbTaxRevenue > 35000 && dbTaxRevenue <=55000) {
            tax = dbTaxRevenue * 0.3 - 2755;
            //月应纳税所得额超过55000元至80000元
        } else if (dbTaxRevenue > 55000 && dbTaxRevenue <=80000) {
            tax = dbTaxRevenue * 0.35 - 5505;
            //月应纳税所得额超过80000元
        } else if (dbTaxRevenue > 80000) {
            tax = dbTaxRevenue * 0.45 - 13505;
        }
    }
        
    NSString* strTax = [NSString stringWithFormat:@"%.2f",tax<0?0:tax];
    return strTax;
}


@end

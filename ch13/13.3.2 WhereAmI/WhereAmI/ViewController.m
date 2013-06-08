//
//  ViewController.m
//  WhereAmI
//
//  Created by 关东升 on 13-1-6.
//  Copyright (c) 2013年 eorient. All rights reserved.
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


- (IBAction)geocodeQuery:(id)sender {
    
    if (_txtQueryKey.text == nil || [_txtQueryKey.text length] == 0) {
        return;
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_txtQueryKey.text completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"查询记录数：%i",[placemarks count]);
        if ([placemarks count] > 0) {
            CLPlacemark* placemark = placemarks[0];

            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            
            
            NSString *urlString = [NSString stringWithFormat:
                                   @"http://maps.google.com/maps?q=%f,%f",
                                   coordinate.latitude,
                                   coordinate.longitude];
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            [[UIApplication sharedApplication] openURL:url];
      
            //关闭键盘
            [_txtQueryKey resignFirstResponder];
        }
    }];

}


@end

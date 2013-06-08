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
            NSString* strCoordinate  = [NSString stringWithFormat:@"经度:%3.5f \n纬度:%3.5f",coordinate.latitude, coordinate.longitude];
            
            NSDictionary *addressDictionary =  placemark.addressDictionary;
            
            NSString *address = [addressDictionary
                                 objectForKey:(NSString *)kABPersonAddressStreetKey];
            address = address == nil ? @"": address;
            
            NSString *state = [addressDictionary
                               objectForKey:(NSString *)kABPersonAddressStateKey];
            state = state == nil ? @"": state;
            
            NSString *city = [addressDictionary
                              objectForKey:(NSString *)kABPersonAddressCityKey];
            city = city == nil ? @"": city;
            
            _txtView.text = [NSString stringWithFormat:@"%@ \n %@ \n%@ \n%@",strCoordinate,state, address,city];
            
            //关闭键盘
            [_txtQueryKey resignFirstResponder];
        }
    }];

}


@end

//
//  ViewController.h
//  WhereAmI
//
//  Created by 关东升 on 13-1-6.
//  Copyright (c) 2013年 eorient. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import "BMapKit.h"

@interface ViewController : UIViewController <BMKSearchDelegate,CLLocationManagerDelegate>

//查询关键字文本框
@property (weak, nonatomic) IBOutlet UITextField *txtQueryKey;

//经度
@property (weak, nonatomic) IBOutlet UITextField *txtLng;
//纬度
@property (weak, nonatomic) IBOutlet UITextField *txtLat;
//高度
@property (weak, nonatomic) IBOutlet UITextField *txtAlt;
//显示结果的文本框
@property (weak, nonatomic) IBOutlet UITextView *txtView;

@property(nonatomic, strong) CLLocationManager *locationManager;

//存储定位结果
@property(nonatomic, strong)  CLLocation *currLocation;

@property (strong, nonatomic)  BMKSearch *search;

//地理信息编码查询
- (IBAction)geocodeQuery:(id)sender;
//地理信息反编码查询
- (IBAction)reverseGeocode:(id)sender;

@end

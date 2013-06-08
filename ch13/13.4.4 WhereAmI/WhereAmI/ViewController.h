//
//  ViewController.h
//  WhereAmI
//
//  Created by 关东升 on 13-1-6.
//  Copyright (c) 2013年 eorient. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <BMKMapViewDelegate,BMKSearchDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtQueryKey;

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@property (strong, nonatomic)  BMKSearch *search;

- (IBAction)geocodeQuery:(id)sender;

@end

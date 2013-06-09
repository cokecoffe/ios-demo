//
//  ViewController.m
//  Core Location
//
//  Created by keke Wang on 13-4-23.
//  Copyright (c) 2013年 uxin. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property CLLocationManager *locManager;

@end



@implementation ViewController


#pragma mark - Location delegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error:%@",[error description]);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *location in locations) {
        NSLog(@"坐标:(%lf,%lf)",location.coordinate.latitude,location.coordinate.longitude);
        NSLog(@"精确度:%lf",location.horizontalAccuracy);
        NSLog(@"获取时间:%@",location.timestamp);
//        NSLog(@"%@",location.description);
    }

//self.mapView.region = MKCoordinateRegionMake([(CLLocation*)(locations.lastObject) coordinate], MKCoordinateSpanMake(0.1f, 0.1f));
self.mapView.region = MKCoordinateRegionMakeWithDistance([(CLLocation*)(locations.lastObject) coordinate], 500.0f, 500.0f);
}


#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.locManager = [[CLLocationManager alloc]init];
    
    if (NO==[CLLocationManager locationServicesEnabled]) {
        NSLog(@"未开启定位");
        return;
    }
    
    self.locManager.delegate = self;
    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;//设置精确度
    self.locManager.distanceFilter = 5.0f;//距离筛选器，设置最小距离通知
    [self.locManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.zoomEnabled = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

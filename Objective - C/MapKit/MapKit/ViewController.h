//
//  ViewController.h
//  MapKit
//
//  Created by Mihail Kalichkov on 3/17/15.
//  Copyright (c) 2015 Mihail Kalichkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <MKMapViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *transportLabel;
@property (weak, nonatomic) IBOutlet UITextView *steps;

@property (strong, nonatomic) NSString *allSteps;

@end


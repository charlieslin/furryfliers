//
//  LocationViewController.h
//  Furry Fliers
//
//  Created by Charlie Lin on 7/6/14.
//  Copyright (c) 2014 Furry Fliers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MenuSubViewController.h"

@interface LocationViewController : MenuSubViewController

@property (strong, nonatomic) IBOutlet MKMapView *petLocationMap;

- (IBAction)close:(id)sender;
@end



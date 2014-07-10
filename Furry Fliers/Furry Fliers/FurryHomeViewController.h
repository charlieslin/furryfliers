//
//  FurryHomeViewController.h
//  Furry Fliers
//
//  Created by Charlie Lin on 7/6/14.
//  Copyright (c) 2014 Furry Fliers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuSubViewController.h"
#import "LocationViewController.h"
#import "ESTBeacon.h"

@interface FurryHomeViewController : UIViewController <MenuSubViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *menuScrollView;
@property (strong, nonatomic) IBOutlet UIView *subviewContainer;


- (IBAction)goBack:(id)sender;
- (IBAction)tapLocation:(id)sender;
- (IBAction)tapChecklist:(id)sender;
- (IBAction)tapActivity:(id)sender;
- (IBAction)tapWeather:(id)sender;
- (IBAction)tapTemperature:(id)sender;
- (IBAction)tapUpgrade:(id)sender;
- (IBAction)tapDistance:(id)sender;
@end

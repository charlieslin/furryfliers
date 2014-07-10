//
//  FurryHomeViewController.m
//  Furry Fliers
//
//  Created by Charlie Lin on 7/6/14.
//  Copyright (c) 2014 Furry Fliers. All rights reserved.
//

#import "FurryHomeViewController.h"
#import "SIMProductViewController.h"
#import "ESTBeaconManager.h"
#import "ESTBeaconTableVC.h"
#import "ESTDistanceDemoVC.h"

#import "ESTTemperatureDemoVC.h"
#import "ESTAccelerometerDemoVC.h"

#import "ViewController.h"

@interface FurryHomeViewController () <ESTBeaconManagerDelegate>

@property (nonatomic, assign)   ESTScanType scanType;

@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *region;
@property (nonatomic, strong) NSArray *beaconsArray;

@end

@implementation FurryHomeViewController
@synthesize menuScrollView;
@synthesize subviewContainer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ESTBeaconManager setupAppID:@"app_1gs9ouejva" andAppToken:@"a16a7feb869b7a46860275406661d1d0"];
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    /*
     * Creates sample region object (you can additionaly pass major / minor values).
     *
     * We specify it using only the ESTIMOTE_PROXIMITY_UUID because we want to discover all
     * hardware beacons with Estimote's proximty UUID.
     */
    self.region = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID
                                                      identifier:@"EstimoteSampleRegion"];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.beaconManager startRangingBeaconsInRegion:self.region];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tapLocation:(id)sender {
    //create the location view controller
    NSLog(@"adding new view controller");
    NSLog(@"containing frame width: %f", self.subviewContainer.frame.size.width);
    
    CGRect subFrame = CGRectMake(0, 192, 320, 376);
    
    UIToolbar* bgToolbar = [[UIToolbar alloc] initWithFrame:subFrame];
    bgToolbar.barStyle = UIBarStyleDefault;
    bgToolbar.tag=99;
    
    
    LocationViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"locationView"];
    newVC.delegate=self;
    [self addChildViewController:newVC];
    newVC.view.frame = subFrame;
    [self.view addSubview:bgToolbar];
    [self.view addSubview:newVC.view];
    
    [newVC didMoveToParentViewController:self];
    //[self.view.superview insertSubview:bgToolbar belowSubview:newVC.view];
    
    
    
    /*
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.subviewContainer setAlpha:1.0];
    [UIView commitAnimations];
    
    UIToolbar* bgToolbar = [[UIToolbar alloc] initWithFrame:self.subviewContainer.frame];
    bgToolbar.barStyle = UIBarStyleDefault;
    [self.subviewContainer.superview insertSubview:bgToolbar belowSubview:self.subviewContainer];
     */
}


-(void) subViewControllerDidRequestClose:(MenuSubViewController *)msvc {
    NSLog(@"received message!\n");
    [msvc willMoveToParentViewController:nil];
    [msvc.view removeFromSuperview];
    [msvc removeFromParentViewController];
    UIView *removeView = [self.view viewWithTag: 99];
    [removeView removeFromSuperview];
    
}

- (IBAction)tapUpgrade:(id)sender{
    
//    CGRect subFrame = CGRectMake(0, 192, 320, 376);
//    
//    UIToolbar* bgToolbar = [[UIToolbar alloc] initWithFrame:subFrame];
//    bgToolbar.barStyle = UIBarStyleDefault;
//    bgToolbar.tag=99;
    
    
    SIMProductViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"upgradeView"];
    //newVC.delegate=self;
//    [self addChildViewController:newVC];
//    newVC.view.frame = subFrame;
//    [self.view addSubview:bgToolbar];
//    [self.view addSubview:newVC.view];
//    
//    [newVC didMoveToParentViewController:self];
    [self presentViewController:newVC animated:YES completion:nil];
    
}

- (IBAction)tapActivity:(id)sender{
    
    if (self.beaconsArray && [self.beaconsArray count] > 0) {
        
        ESTBeacon *selectedBeacon = [self.beaconsArray objectAtIndex:0];
        
        //ESTTemperatureDemoVC *distanceDemoVC = [[ESTTemperatureDemoVC alloc] initWithBeacon:selectedBeacon];
        ESTAccelerometerDemoVC *distanceDemoVC = [[ESTAccelerometerDemoVC alloc] initWithBeacon:selectedBeacon];
        //[self.navigationController pushViewController:distanceDemoVC animated:YES];
        //ESTDistanceDemoVC *distanceDemoVC = [[ESTDistanceDemoVC alloc] initWithBeacon:selectedBeacon];
        [self presentViewController:distanceDemoVC animated:YES completion:nil];
        
    }

}

- (IBAction)tapTemperature:(id)sender{
    
    if (self.beaconsArray && [self.beaconsArray count] > 0) {
        
        ESTBeacon *selectedBeacon = [self.beaconsArray objectAtIndex:0];
        
        ESTTemperatureDemoVC *distanceDemoVC = [[ESTTemperatureDemoVC alloc] initWithBeacon:selectedBeacon];
        //ESTAccelerometerDemoVC *distanceDemoVC = [[ESTAccelerometerDemoVC alloc] initWithBeacon:selectedBeacon];
        //[self.navigationController pushViewController:distanceDemoVC animated:YES];
        //ESTDistanceDemoVC *distanceDemoVC = [[ESTDistanceDemoVC alloc] initWithBeacon:selectedBeacon];
        [self presentViewController:distanceDemoVC animated:YES completion:nil];
        
    }
    
    
    
    
}


- (IBAction)tapDistance:(id)sender{
    
    if (self.beaconsArray && [self.beaconsArray count] > 0) {
        
        ESTBeacon *selectedBeacon = [self.beaconsArray objectAtIndex:0];
        
        ESTDistanceDemoVC *distanceDemoVC = [[ESTDistanceDemoVC alloc] initWithBeacon:selectedBeacon];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:distanceDemoVC];
        [self presentViewController:nav animated:YES completion:nil];
        
    }
    
    
}


- (IBAction)tapWeather:(id)sender{
    

    ViewController *weatherVC = [self.storyboard instantiateViewControllerWithIdentifier:@"weather"];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:weatherVC];
    [self presentViewController:nav animated:YES completion:nil];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.beaconsArray = beacons;
    
    if ([self.beaconsArray count] > 0) {
        [self.beaconManager stopRangingBeaconsInRegion:self.region];
        [self.beaconManager stopEstimoteBeaconDiscovery];
    }

    
    //[self.tableView reloadData];
}

- (void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.beaconsArray = beacons;
    
    if ([self.beaconsArray count] > 0) {
        [self.beaconManager stopRangingBeaconsInRegion:self.region];
        [self.beaconManager stopEstimoteBeaconDiscovery];
    }

    
    //[self.tableView reloadData];
}

@end

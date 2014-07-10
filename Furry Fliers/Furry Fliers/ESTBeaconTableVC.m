//
//  ESTBeaconTableVC.m
//  DistanceDemo
//
//  Created by Grzegorz Krukiewicz-Gacek on 17.03.2014.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import "ESTBeaconTableVC.h"
#import "ESTBeaconManager.h"


@interface ESTBeaconTableVC () <ESTBeaconManagerDelegate>

@property (nonatomic, copy)     void (^completion)(ESTBeacon *);
@property (nonatomic, assign)   ESTScanType scanType;

@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *region;
@property (nonatomic, strong) NSArray *beaconsArray;

@end


@implementation ESTBeaconTableVC

- (id)initWithScanType:(ESTScanType)scanType completion:(void (^)(ESTBeacon *))completion
{
    self = [super init];
    if (self)
    {
        self.scanType = scanType;
        self.completion = [completion copy];
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
        
        /*
         * Starts looking for Estimote beacons.
         * All callbacks will be delivered to beaconManager delegate.
         */
        if (self.scanType == ESTScanTypeBeacon)
        {
            [self.beaconManager startRangingBeaconsInRegion:self.region];
        }
        else
        {
            [self.beaconManager startEstimoteBeaconsDiscoveryForRegion:self.region];
        }
    }
    return self;
}





- (void)viewDidDisappear:(BOOL)animated
{
    //[super viewDidDisappear:animated];
    
    /*
     *Stops ranging after exiting the view.
     */
    [self.beaconManager stopRangingBeaconsInRegion:self.region];
    [self.beaconManager stopEstimoteBeaconDiscovery];
}



#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.beaconsArray = beacons;
    
    //[self.tableView reloadData];
}

- (void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.beaconsArray = beacons;
    
    //[self.tableView reloadData];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESTBeacon *selectedBeacon = [self.beaconsArray objectAtIndex:indexPath.row];
    
    self.completion(selectedBeacon);
    //[self dismissViewControllerAnimated:NO completion:nil];
}

@end

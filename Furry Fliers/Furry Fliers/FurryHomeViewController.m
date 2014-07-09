//
//  FurryHomeViewController.m
//  Furry Fliers
//
//  Created by Charlie Lin on 7/6/14.
//  Copyright (c) 2014 Furry Fliers. All rights reserved.
//

#import "FurryHomeViewController.h"
#import "SIMProductViewController.h"

@interface FurryHomeViewController ()

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
    
    [self setNeedsStatusBarAppearanceUpdate];
    
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
    
    CGRect subFrame = CGRectMake(0, 192, 320, 376);
    
    UIToolbar* bgToolbar = [[UIToolbar alloc] initWithFrame:subFrame];
    bgToolbar.barStyle = UIBarStyleDefault;
    bgToolbar.tag=99;
    
    
    SIMProductViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"upgradeView"];
    //newVC.delegate=self;
    [self addChildViewController:newVC];
    newVC.view.frame = subFrame;
    [self.view addSubview:bgToolbar];
    [self.view addSubview:newVC.view];
    
    [newVC didMoveToParentViewController:self];
    
    
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

@end

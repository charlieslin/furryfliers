//
//  MenuSubViewController.h
//  Furry Fliers
//
//  Created by Charlie Lin on 7/6/14.
//  Copyright (c) 2014 Furry Fliers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuSubViewControllerDelegate;

@interface MenuSubViewController : UIViewController
@property (weak, nonatomic) id<MenuSubViewControllerDelegate> delegate;


@end

@protocol MenuSubViewControllerDelegate <NSObject>

@optional

- (void) subViewControllerDidRequestClose:(MenuSubViewController *) msvc;

@end

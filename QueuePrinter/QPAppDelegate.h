//
//  QPAppDelegate.h
//  QueuePrinter
//
//  Created by Omar Gudino on 10/21/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QPViewController;

@interface QPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) QPViewController *viewController;

@end

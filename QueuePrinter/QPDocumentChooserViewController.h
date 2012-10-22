//
//  QPDocumentChooserViewController.h
//  QueuePrinter
//
//  Created by Omar Gudino on 10/21/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QPDocumentChooserViewController;

@protocol QPDocumentChooserViewControllerDelegate

- (void)documentChooser:(QPDocumentChooserViewController *)documentChooser didChooseFileWithName:(NSString *)name fileSize:(NSString *)size;

@end

@interface QPDocumentChooserViewController : UIViewController

@property (assign, nonatomic) id<QPDocumentChooserViewControllerDelegate> delegate;

@end

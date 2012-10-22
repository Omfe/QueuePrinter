//
//  QPViewController.m
//  QueuePrinter
//
//  Created by Omar Gudino on 10/21/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import "QPViewController.h"
#import "QPDocumentChooserViewController.h"
#import "QPQueue.h"

@interface QPViewController () <UITableViewDataSource, UITableViewDelegate, QPDocumentChooserViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *printingProgressBar;
@property (weak, nonatomic) IBOutlet UITableView *queueTableView;

@property (strong, nonatomic) QPQueue *queue;

@end

@implementation QPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.queue = [[QPQueue alloc] init];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.queue.queueArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *object;
    UITableViewCell *cell;
    static NSString *identifier = @"InformationTableViewCellIdentifier";
    
    cell = [self.queueTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    object = [self.queue.queueArray objectAtIndex:indexPath.row];
    cell.textLabel.text = object;
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - QPDocumentChooserViewControllerDelegate Methods
- (void)documentChooser:(QPDocumentChooserViewController *)documentChooser didChooseFileWithName:(NSString *)name fileSize:(NSString *)size
{
    
}

#pragma mark - Action Methods
- (IBAction)chooseFileWasPressed:(id)sender
{
    
}

@end

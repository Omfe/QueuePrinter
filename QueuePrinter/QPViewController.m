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
@property (assign, nonatomic) BOOL isPrinting;

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
    static NSString *identifier = @"QueueTableViewCellIdentifier";
    
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
    NSArray *indexPaths;
    NSIndexPath *indexPath;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.queue pushObject:name];
    indexPath = [NSIndexPath indexPathForRow:self.queue.queueArray.count-1 inSection:0];
    indexPaths = [NSArray arrayWithObject:indexPath];
    [self.queueTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    [self startProgressView];
}

#pragma mark - Action Methods
- (IBAction)chooseFileWasPressed:(id)sender
{
    QPDocumentChooserViewController *documentChooser;
    
    documentChooser = [[QPDocumentChooserViewController alloc] initWithNibName:@"QPDocumentChooserViewController" bundle:nil];
    documentChooser.delegate = self;
    [self presentViewController:documentChooser animated:YES completion:nil];
}

#pragma mark - Private Methods
- (void)startProgressView
{
    dispatch_queue_t dispatchQueue;
    
    if (self.isPrinting) {
        return;
    }
    
    self.isPrinting = YES;
    dispatchQueue = dispatch_queue_create("com.Omfe.progressbarqueue", NULL);
    dispatch_async(dispatchQueue, ^{
        for (CGFloat i = 0; i <= 100; i += 10) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *indexPaths;
                NSIndexPath *indexPath;
                
                [self.printingProgressBar setProgress:i/100 animated:YES];
                if (self.printingProgressBar.progress == 1) {
                    indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    indexPaths = [NSArray arrayWithObject:indexPath];
                    
                    [self.queue popAnObject];
                    [self.queueTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
                    [self resetProgressView];
                }
            });
            sleep(1);
        }
    });
}

- (void)resetProgressView
{
    self.printingProgressBar.progress = 0;
    self.isPrinting = NO;
    
    if (self.queue.queueArray.count > 0) {
        [self startProgressView];
    }
}

@end

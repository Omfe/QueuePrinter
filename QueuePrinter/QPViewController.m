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
    indexPath = [NSIndexPath indexPathForRow:self.queue.queueArray.count-1 inSection:0];
    indexPaths = [NSArray arrayWithObject:indexPath];
    [self.queue pushObject:name];
    [self.queueTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    [self startProgress];
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
- (void)startProgress
{
    int64_t delayInSeconds;
    dispatch_time_t popTime;
    dispatch_queue_t queue;
    
    if (self.isPrinting) {
        return;
    }
    
    delayInSeconds = 0.1;
    popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    queue = dispatch_queue_create("com.Omfe.progressbarqueue", NULL);
    
    for (NSInteger i = 0; i < 100; i++) {
        dispatch_after(popTime, queue, ^(void){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *indexPaths;
                NSIndexPath *indexPath;
                
                self.printingProgressBar.progress++;
                if (self.printingProgressBar.progress == 1) {
                    indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    indexPaths = [NSArray arrayWithObject:indexPath];
                    
                    [self.queue popAnObject];
                    [self.queueTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
                    [self resetProgressView];
                }
            });
        });
    }
}

- (void)resetProgressView
{
    self.printingProgressBar.progress = 0;
    self.isPrinting = NO;
    
    if (self.queue.queueArray.count > 0) {
        [self startProgress];
    }
}

@end

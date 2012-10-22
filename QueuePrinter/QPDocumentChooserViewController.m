//
//  QPDocumentChooserViewController.m
//  QueuePrinter
//
//  Created by Omar Gudino on 10/21/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import "QPDocumentChooserViewController.h"

@interface QPDocumentChooserViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *filesTableView;

@end

@implementation QPDocumentChooserViewController


- (void)viewDidLoad
{
    NSArray *filePaths;
    NSString *fileName;
    NSString *fileSize;
    NSDictionary *fileAttributes;
    
    [super viewDidLoad];
    self.documentNameArray = [[NSMutableArray array] init];
    self.documentSizeArray = [[NSMutableArray array] init];
    
    filePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"docx" inDirectory:@""];
    for (NSString *filePath in filePaths) {
        fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        fileSize = [[fileAttributes objectForKey:@"NSFileSize"] stringValue];
        fileSize = [fileSize stringByAppendingString:@" bytes"];
        fileName = [filePath lastPathComponent];
        
        [self.documentNameArray addObject:fileName];
        [self.documentSizeArray addObject:fileSize];
    }
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.documentNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *identifier = @"DocumentChooserTableViewCellIdentifier";
    NSString *fileName;
    NSString *fileSize;
    
    fileName = [self.documentNameArray objectAtIndex:indexPath.row];
    fileSize = [self.documentSizeArray objectAtIndex:indexPath.row];
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = fileName;
    cell.detailTextLabel.text = fileSize;
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fileName;
    NSString *fileSize;
    
    fileName = [self.documentNameArray objectAtIndex:indexPath.row];
    fileSize = [self.documentSizeArray objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate documentChooser:self didChooseFileWithName:fileName fileSize:fileSize];
}

@end

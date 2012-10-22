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
    
    filePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"docx" inDirectory:@""];
    for (NSString *filePath in filePaths) {
        fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        fileSize = [[fileAttributes objectForKey:@"NSFileSize"] stringValue];
        fileSize = [fileSize stringByAppendingString:@" bytes"];
        fileName = [filePath lastPathComponent];
        
        NSLog(@"%@, %@", fileName, fileSize);
        // Agregar el fileName y el fileSize a su respectivo arreglo.
    }
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *identifier = @"DocumentChooserTableViewCellIdentifier";
    
    //cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    //cell.textLabel.text = ?;
    //cell.detailTextLabel.text = ?;
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

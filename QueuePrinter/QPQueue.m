//
//  QPQueue.m
//  QueuePrinter
//
//  Created by Omar Gudino on 10/21/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import "QPQueue.h"

@implementation QPQueue

- (id)init
{
    self = [super init];
    if (self) {
        self.queueArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Public Methods
- (void)pushAnObject
{
    NSString *object;
    
    object = [[NSString alloc]initWithFormat:@"%i", self.queueArray.count]; //Inicializar String
    [self pushObject:object];
}

- (void)popAnObject
{
    [self.queueArray removeObjectAtIndex:0];
}

- (void)pushObject:(NSString *)object
{
    [self.queueArray addObject:object];
}

@end
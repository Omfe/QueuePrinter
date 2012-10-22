//
//  QPQueue.h
//  QueuePrinter
//
//  Created by Omar Gudino on 10/21/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QPQueue : NSObject

@property (strong, nonatomic) NSMutableArray *queueArray;

- (void)pushAnObject;
- (void)popAnObject;
- (void)pushObject:(NSString *)object;

@end

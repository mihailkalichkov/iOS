//
//  MKTask.m
//  MKTaskManager
//
//  Created by Mihail Kalichkov on 12/21/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import "MKTask.h"

@implementation MKTask

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self) {
        self.title = data[TASK_TITLE];
        self.detailedDescription = data[TASK_DESCRIPTION];
        self.date = data[TASK_DATE];
        self.isCompleted = [data[TASK_COMPLETION] boolValue];
    }
    
    return self;
}

-(id)init
{
    self = [self initWithData:nil];
    
    return self;
}

@end

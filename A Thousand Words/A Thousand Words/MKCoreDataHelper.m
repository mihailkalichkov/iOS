//
//  MKCoreDataHelper.m
//  A Thousand Words
//
//  Created by Mihail Kalichkov on 1/10/15.
//  Copyright (c) 2015 Mihail Kalichkov. All rights reserved.
//

#import "MKCoreDataHelper.h"

@implementation MKCoreDataHelper

+(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

@end

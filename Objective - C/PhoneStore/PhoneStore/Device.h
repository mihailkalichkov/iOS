//
//  Device.h
//  PhoneStore
//
//  Created by Mihail Kalichkov on 5/21/15.
//  Copyright (c) 2015 Mihail Kalichkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Device : NSManagedObject

@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * version;

@end

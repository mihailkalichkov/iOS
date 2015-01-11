//
//  Album.h
//  A Thousand Words
//
//  Created by Mihail Kalichkov on 1/10/15.
//  Copyright (c) 2015 Mihail Kalichkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;

@end

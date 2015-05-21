//
//  MKTask.h
//  MKTaskManager
//
//  Created by Mihail Kalichkov on 12/21/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKTask : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detailedDescription;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL isCompleted;

-(id)initWithData:(NSDictionary *)data;

@end

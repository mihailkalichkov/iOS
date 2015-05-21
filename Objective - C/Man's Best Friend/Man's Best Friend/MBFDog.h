//
//  MBFDog.h
//  Man's Best Friend
//
//  Created by Mihail Kalichkov on 11/4/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface MBFDog : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) int age;
@property (strong, nonatomic) NSString *breed;
@property (strong, nonatomic) UIImage *image;

@end

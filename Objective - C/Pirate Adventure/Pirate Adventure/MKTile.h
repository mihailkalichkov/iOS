//
//  MKTile.h
//  Pirate Adventure
//
//  Created by Mihail Kalichkov on 11/14/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface MKTile : NSObject

@property (strong, nonatomic) NSString *story;
@property (strong, nonatomic) UIImage *backgroundImage;
@property (strong, nonatomic) NSString *actionButtonName;

@end

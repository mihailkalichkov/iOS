//
//  MKAlbumTableViewController.h
//  A Thousand Words
//
//  Created by Mihail Kalichkov on 1/10/15.
//  Copyright (c) 2015 Mihail Kalichkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKAlbumTableViewController : UITableViewController 

@property (strong, nonatomic) NSMutableArray *albums; 

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender;

@end

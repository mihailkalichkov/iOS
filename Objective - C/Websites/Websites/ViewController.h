//
//  ViewController.h
//  Websites
//
//  Created by Mihail Kalichkov on 3/11/15.
//  Copyright (c) 2015 Mihail Kalichkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end


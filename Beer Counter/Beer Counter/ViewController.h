//
//  ViewController.h
//  Beer Counter
//
//  Created by Mihail Kalichkov on 10/30/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *littersDrunkLabel;
@property (strong, nonatomic) IBOutlet UITextField *beersDrunkTextField;
- (IBAction)calculateLittersDrunk:(UIButton *)sender;

@end


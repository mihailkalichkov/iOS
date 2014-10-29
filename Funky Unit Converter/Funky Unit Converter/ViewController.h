//
//  ViewController.h
//  Funky Unit Converter
//
//  Created by Mihail Kalichkov on 10/29/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *numberOfFootballFieldsLabel;
@property (strong, nonatomic) IBOutlet UITextField *numberOfBillsTextField;

- (IBAction)convertUnits:(UIButton *)sender;

@end


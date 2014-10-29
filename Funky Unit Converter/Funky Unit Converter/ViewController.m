//
//  ViewController.m
//  Funky Unit Converter
//
//  Created by Mihail Kalichkov on 10/29/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)convertUnits:(UIButton *)sender {
    float numberOfBills = [self.numberOfBillsTextField.text floatValue];
    float numberOfFootballFields = numberOfBills / 91440;
    self.numberOfFootballFieldsLabel.text = [NSString stringWithFormat:@"%f", numberOfFootballFields];
}
@end

//
//  ViewController.m
//  Beer Counter
//
//  Created by Mihail Kalichkov on 10/30/14.
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

- (IBAction)calculateLittersDrunk:(UIButton *)sender {
    float beersDrunk = [self.beersDrunkTextField.text floatValue];
    float littersDrunk = beersDrunk / 2;
    self.littersDrunkLabel.text = [NSString stringWithFormat:@"%.1fl",littersDrunk];
}
@end

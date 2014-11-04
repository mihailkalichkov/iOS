//
//  ViewController.m
//  Man's Best Friend
//
//  Created by Mihail Kalichkov on 11/4/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import "ViewController.h"
#import "MBFDog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MBFDog *myDog = [[MBFDog alloc] init];
    myDog.breed = @"Labrador";
    myDog.name = @"Sharo";
    myDog.image = [UIImage imageNamed:@"Labrador.JPG"];
    
    self.myImage.image = myDog.image;
    self.nameLabel.text = myDog.name;
    self.breedLabel.text = myDog.breed;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

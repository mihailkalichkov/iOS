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
    self.currentIndex = 0;
    
    MBFDog *secondDog = [[MBFDog alloc] init];
    secondDog.breed = @"Yorkshire terrier";
    secondDog.name = @"Leo";
    secondDog.image = [UIImage imageNamed:@"yorkshire-terrier.jpeg"];
    
    MBFDog *thirdDog = [[MBFDog alloc] init];
    thirdDog.breed = @"Husky";
    thirdDog.name = @"Fluffy";
    thirdDog.image = [UIImage imageNamed:@"husky.jpg"];
    
    MBFDog *fourthDog = [[MBFDog alloc] init];
    fourthDog.breed = @"German shepherd";
    fourthDog.name = @"Sarrah";
    fourthDog.image = [UIImage imageNamed:@"german-shepherd.jpg"];
    
    self.myDogs = [[NSMutableArray alloc] init];
    [self.myDogs addObject:myDog];
    [self.myDogs addObject:secondDog];
    [self.myDogs addObject:thirdDog];
    [self.myDogs addObject:fourthDog];
    NSLog(@"%@", self.myDogs);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)NewDogButtonPressed:(UIBarButtonItem *)sender {
    int numberOfDogs = [self.myDogs count];
    int randomIndex = arc4random() % numberOfDogs;
    
    if (self.currentIndex == randomIndex && self.currentIndex == 0) {
        randomIndex++;
    }
    else if (self.currentIndex == randomIndex){
        randomIndex--;
    }
    
    self.currentIndex = randomIndex;
    
    MBFDog *randomDog = [self.myDogs objectAtIndex:randomIndex];
    self.myImage.image = randomDog.image;
    self.breedLabel.text = randomDog.breed;
    self.nameLabel.text = randomDog.name;
    sender.title = @"And Another";
}

@end

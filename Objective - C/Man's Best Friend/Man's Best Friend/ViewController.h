//
//  ViewController.h
//  Man's Best Friend
//
//  Created by Mihail Kalichkov on 11/4/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *breedLabel;
@property (strong, nonatomic) IBOutlet UIImageView *myImage;
@property (strong, nonatomic) NSMutableArray *myDogs;
@property (nonatomic) int currentIndex;

- (IBAction)NewDogButtonPressed:(UIBarButtonItem *)sender;


@end


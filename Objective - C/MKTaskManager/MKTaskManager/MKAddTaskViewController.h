//
//  MKAddTaskViewController.h
//  MKTaskManager
//
//  Created by Mihail Kalichkov on 12/21/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKTask.h"

@protocol MKAddTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask:(MKTask *)task;

@end

@interface MKAddTaskViewController : UIViewController

@property (weak, nonatomic) id <MKAddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end

//
//  DetailViewController.h
//  
//
//  Created by Mihail Kalichkov on 5/21/15.
//
//

#import <UIKit/UIKit.h>
#import "Device.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *versionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;

@property (strong) NSManagedObject *device;

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;

@end

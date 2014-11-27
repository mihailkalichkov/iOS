//
//  MKOuterSpaceTableViewController.m
//  Out Of This World
//
//  Created by Mihail Kalichkov on 11/27/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import "MKOuterSpaceTableViewController.h"

@interface MKOuterSpaceTableViewController ()

@end

@implementation MKOuterSpaceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.planets = [[NSMutableArray alloc] init];
    
    NSString *firstPlanet = @"Mercury";
    NSString *secondPlanet = @"Venus";
    NSString *thirdPlanet = @"Earth";
    NSString *fourthPlanet = @"Mars";
    NSString *fifthPlanet = @"Jupiter";
    NSString *sixthPlanet = @"Saturn";
    NSString *seventhPlanet = @"Uranus";
    NSString *eightPlanet = @"Neptune";
    
    [self.planets addObject:firstPlanet];
    [self.planets addObject:secondPlanet];
    [self.planets addObject:thirdPlanet];
    [self.planets addObject:fourthPlanet];
    [self.planets addObject:fifthPlanet];
    [self.planets addObject:sixthPlanet];
    [self.planets addObject:seventhPlanet];
    [self.planets addObject:eightPlanet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    return [self.planets count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.planets objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor redColor];
    }
    else{
        cell.backgroundColor = [UIColor blueColor];
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
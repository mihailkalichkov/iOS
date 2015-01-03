//
//  ViewController.m
//  MKTaskManager
//
//  Created by Mihail Kalichkov on 12/21/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(NSMutableArray *)taskObjects
{
    if (!_taskObjects) {
        _taskObjects = [[NSMutableArray alloc] init];
    }
    
    return _taskObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY];
    
    for (NSDictionary *dictionary in tasksAsPropertyLists){
        MKTask *taskObject = [self taskObjectForDictionary:dictionary];
        [self.taskObjects addObject:taskObject];
    }
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[MKAddTaskViewController class]]) {
        MKAddTaskViewController *addTaskViewController = segue.destinationViewController;
        addTaskViewController.delegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender {
}

- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSeque" sender:nil];
}

#pragma mark MKAddTaskViewControllerDelegate

-(void)didAddTask:(MKTask *)task
{
    [self.taskObjects addObject:task];
    
    NSMutableArray *taskObjectsAsPropertyLists= [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    if (!taskObjectsAsPropertyLists) {
        taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    }
    
    [taskObjectsAsPropertyLists addObject:[self taskObjectAsAPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper Methods

-(NSDictionary *)taskObjectAsAPropertyList:(MKTask *)taskObject
{
    NSDictionary *dictionary = @{TASK_TITLE: taskObject.title, TASK_DESCRIPTION: taskObject.description, TASK_DATE: taskObject.date, TASK_COMPLETION: @(taskObject.isCompleted)};
    
    return dictionary;
}

-(MKTask *)taskObjectForDictionary:(NSDictionary *)dictionary
{
    MKTask* taskObject = [[MKTask alloc] initWithData:dictionary];
    
    return taskObject;
}

-(BOOL)isDateGreaterthanDate:(NSDate *)date and:(NSDate *)toDate
{
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if (dateInterval > toDateInterval) {
        return YES;
    }
    else {
        return NO;
    }
}

-(void)updateCompletionOfTask:(MKTask *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *taskObjectsAsPropertyLists =[[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    if (!taskObjectsAsPropertyLists)
    {
        taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    }
    
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    if (task.isCompleted == YES) {
        task.isCompleted = NO;
    }
    else{
        task.isCompleted = YES;
    }
    
    [taskObjectsAsPropertyLists insertObject:[self taskObjectAsAPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskObjects count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Configure the cell...
    
    MKTask *task = self.taskObjects[indexPath.row];
    cell.textLabel.text = task.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:task.date];
    cell.detailTextLabel.text = stringFromDate;
    
    BOOL isOverdue = [self isDateGreaterthanDate:[NSDate date] and:task.date];
    
    if (task.isCompleted == YES) {
        cell.backgroundColor = [UIColor greenColor];
    }
    else if (isOverdue == YES) {
        cell.backgroundColor = [UIColor redColor];
    }
    else{
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKTask *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}


@end

//
//  ViewController.m
//  Websites
//
//  Created by Mihail Kalichkov on 3/11/15.
//  Copyright (c) 2015 Mihail Kalichkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    NSArray *websites;
    NSMutableArray *websiteIcons;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    websites = [NSArray arrayWithObjects:@"google.com", @"amazon.com",
                @"microsoft.com", @"apple.com", @"oreilly.com", nil];
    websiteIcons = [[NSMutableArray alloc] init];
    
    
    for (NSString* website in websites) {
        [websiteIcons addObject:[NSNull null]];
    }
    
    NSOperationQueue* backgroundQueue = [[NSOperationQueue alloc] init];
    
    int websiteNumber = 0;
    
    
    for (NSString* website in websites) {
        [backgroundQueue addOperationWithBlock:^{
       
        NSURL* iconURL = [NSURL URLWithString:
                          [NSString stringWithFormat:@"http://%@/favicon.ico", website]];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:iconURL];
            
        NSData* loadedData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if (loadedData != nil) {
            // We got image data! Convert it to an image.
            UIImage* loadedImage = [UIImage imageWithData:loadedData];
            // If the data wasn't able to be turned into an image, stop
            if (loadedImage == nil) {
                return;
            }
            // If it was, insert the image into the
            // table view on the main queue.
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [websiteIcons replaceObjectAtIndex:websiteNumber
                                        withObject:loadedImage];
                [self.tableView reloadData];
            }];
        } }];
        websiteNumber++;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of cells = number of websites
    return [websiteIcons count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get a cell from the table view.
    UITableViewCell* cell = [tableView
                             dequeueReusableCellWithIdentifier:@"IconCell"];
    // Take the website name and give that to the cell
    NSString* websiteName = [websites objectAtIndex:indexPath.row];
    cell.textLabel.text = websiteName;
    // If we have an image for this website, give it to the cell
    UIImage* websiteImage = [websiteIcons objectAtIndex:indexPath.row];
    if ((NSNull*)websiteImage != [NSNull null]) {
        cell.imageView.image = websiteImage;
    }
    return cell;
}

@end

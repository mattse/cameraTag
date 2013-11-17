//
//  RoundViewController.m
//  LaserTag
//
//  Created by Matthew on 11/16/13.
//  Copyright (c) 2013 Andrew Shim. All rights reserved.
//

#import "RoundViewController.h"
#import "RoundsViewController.h"
#import "LTViewController.h"

@interface RoundViewController ()

@end

@implementation RoundViewController
@synthesize roundJSON;
NSMutableArray* usersArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString * roundName = [roundJSON objectForKey:@"roundName"];
    usersArray = [roundJSON objectForKey:@"users"];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterRound:(id)sender {

    NSString *userName = RoundsViewController.myName;
    NSLog(@"Username: %@\n", userName);
    NSString *roundID = [roundJSON objectForKey:@"_id"];
    NSString * urlString = [NSString stringWithFormat:@"http://10.190.72.149:8080/rounds/register/%@/%@", userName, roundID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];

    NSURLResponse *urlResponse = nil;
    NSError *requestError;
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    if (response1 !=  nil) {
        NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:response1 options:kNilOptions error:&requestError];
        NSLog(@"response: %@\n", jsonArray);
    }
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LTViewController *viewController = (LTViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LTViewController"];
    [viewController setModalPresentationStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:viewController animated:YES completion:nil];
    

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return [usersArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    
    NSDictionary* roundObject = [usersArray objectAtIndex:indexPath.row];
    NSString* userName = [roundObject objectForKey:@"name"];
    NSString* score = [roundObject objectForKey:@"score"];
    NSString* scoreString = [NSString stringWithFormat:@"Score: %@", score];
    cell.textLabel.text = userName;
    cell.detailTextLabel.text = scoreString;
    

    // set the accessory view:
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end

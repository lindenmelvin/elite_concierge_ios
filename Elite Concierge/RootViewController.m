//
//  RootViewController.m
//  Elite Concierge
//
//  Created by Linden Melvin on 6/30/13.
//  Copyright (c) 2013 Linden Melvin. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *user = [NSEntityDescription entityForName:@"User" inManagedObjectContext: context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:user];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"logged_in == true"];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSInteger count = [context countForFetchRequest:request error:&error];
    
    if (!error){
        
        if( count == 1) {
            NSArray *results = [context executeFetchRequest:request error:&error];
            
            if(!results || error) {
                NSLog(@"Core Data Error : %@", [error description]);
                return;
            }
            
            currentUser = results[0];
            return [self performSegueWithIdentifier:@"userLoggedInSegue" sender:nil];
        }
    }
    
    [self performSegueWithIdentifier:@"userLoginSegue" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"userLoggedInSegue"]) {
        UserViewController *destViewController = segue.destinationViewController;
        destViewController.currentUser = currentUser;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

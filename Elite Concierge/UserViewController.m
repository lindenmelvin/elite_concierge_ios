//
//  UserViewController.m
//  Elite Concierge
//
//  Created by Linden Melvin on 6/25/13.
//  Copyright (c) 2013 Linden Melvin. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

@synthesize currentUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)logout:(UIBarButtonItem *)sender {
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *user = [NSEntityDescription entityForName:@"User" inManagedObjectContext: context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:user];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"authentication_token == %@", currentUser.authentication_token];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    NSError *saveError;
    [results[0] setLogged_in:@NO];
    
    if (![context save:&saveError]) {
        NSLog(@"Logout failed: %@", saveError);
    } else {
        NSLog(@"Logout successful!");
    }
    
    [self performSegueWithIdentifier:@"userLogoutSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"serviceRequestsSegue"]) {
        ServiceRequestViewController *destViewController = segue.destinationViewController;
        destViewController.currentUser = currentUser;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *welcome_message = [[NSArray alloc] initWithObjects:@"Welcome, ", currentUser.first_name, currentUser.last_name, nil];
    welcome.text = [welcome_message componentsJoinedByString:@" "];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationItem setHidesBackButton:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

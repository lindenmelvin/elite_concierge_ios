//
//  LoginViewController.m
//  Elite Concierge
//
//  Created by Linden Melvin on 7/3/13.
//  Copyright (c) 2013 Linden Melvin. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)login:(UIButton *)sender {
    NSString *email = emailField.text;
    NSString *password = passwordField.text;
        
    if([email isEqualToString:@""] || [password isEqualToString:@""]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Invalid Credentials"
                                                          message:@"You must provide an email and password."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        return;
    }
    [spinner startAnimating];
    [login_button setEnabled:NO];
    NSString *fullPath = @"http://elite-concierge.herokuapp.com/api/user/login.json";
    NSURL *url = [NSURL URLWithString:@"http://elite-concierge.herokuapp.com/api/user"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:url];
    
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:
                            email,@"user[email]",
                            password,@"user[password]",
                            nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:fullPath parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                          
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            NSDictionary *jsonDictionary = JSON;
            [spinner stopAnimating];
            [self createUserUnlessExists:jsonDictionary];
            [self performSegueWithIdentifier:@"LoginSegue" sender:currentUser];
            [login_button setEnabled:YES];
        }
                                         
        failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON) {
            NSDictionary *jsonDictionary = JSON;
            NSString *error_message = [jsonDictionary valueForKey:@"message"];
            welcomeMessage.text = error_message;
            [spinner stopAnimating];
            [login_button setEnabled:YES];
        }];
        [operation start];
}

-(void)createUserUnlessExists:(NSDictionary*)userData {
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *user = [NSEntityDescription entityForName:@"User" inManagedObjectContext: context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:user];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"authentication_token == %@", [userData valueForKey:@"authentication_token"]];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSInteger count = [context countForFetchRequest:request error:&error];
    
    if (!error){        
        if(count == 0) {
            [self createUser:userData];
        }
        
        NSArray *results = [context executeFetchRequest:request error:&error];
        
        if(!results || error) {
            NSLog(@"Core Data Error : %@", [error description]);
            return;
        }
        
        NSError *saveError;
        [results[0] setLogged_in:@YES];
        
        if (![context save:&saveError]) {
            NSLog(@"Logint failed: %@", saveError);
        } else {
            NSLog(@"Login successful!");
        }
        
        currentUser = results[0];
    } else {
        return;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LoginSegue"]) {
        UserViewController *destViewController = segue.destinationViewController;
        destViewController.currentUser = currentUser;
    }
}

-(void)createUser:(NSDictionary*)userData {
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    user.email = [userData valueForKey:@"email"];
    user.authentication_token = [userData valueForKey:@"authentication_token"];
    user.logged_in = @YES;
    
    NSLog(@"%@", user);
    
    NSError *error;
    
    [context save:&error];
    
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
}

- (void)viewDidLoad {
    [self.view addSubview:spinner];
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    passwordField.secureTextEntry = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationItem setHidesBackButton:YES animated:YES];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

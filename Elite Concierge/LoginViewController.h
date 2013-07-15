//
//  LoginViewController.h
//  Elite Concierge
//
//  Created by Linden Melvin on 7/3/13.
//  Copyright (c) 2013 Linden Melvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "User.h"
#import "UserViewController.h"

@interface LoginViewController : UIViewController {
    IBOutlet UITextField *emailField;
    IBOutlet UITextField *passwordField;
    IBOutlet UILabel *welcomeMessage;
    IBOutlet UIActivityIndicatorView *spinner;
    IBOutlet UIButton *login_button;
    NSUserDefaults *user_defaults;
    AppDelegate *appDelegate;
    User *currentUser;
}

- (IBAction)login:(UIButton *)sender;
@end

//
//  UserViewController.h
//  Elite Concierge
//
//  Created by Linden Melvin on 6/25/13.
//  Copyright (c) 2013 Linden Melvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "AppDelegate.h"
#import "ServiceRequestViewController.h"

@interface UserViewController : UIViewController {
    IBOutlet UILabel *welcome;
    AppDelegate *appDelegate;
}
- (IBAction)logout:(UIBarButtonItem *)sender;


@property (nonatomic, strong) User *currentUser;

@end

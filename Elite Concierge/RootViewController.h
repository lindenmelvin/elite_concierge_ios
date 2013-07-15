//
//  RootViewController.h
//  Elite Concierge
//
//  Created by Linden Melvin on 7/14/13.
//  Copyright (c) 2013 Linden Melvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserViewController.h"
#import "AppDelegate.h"

@interface RootViewController : UIViewController {
    AppDelegate *appDelegate;
    User *currentUser;
}

@end

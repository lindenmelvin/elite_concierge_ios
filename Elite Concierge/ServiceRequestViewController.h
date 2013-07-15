//
//  ServiceRequestViewController.h
//  Elite Concierge
//
//  Created by Linden Melvin on 7/3/13.
//  Copyright (c) 2013 Linden Melvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "User.h"

@interface ServiceRequestViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
    UIPickerView * subjectPicker;
    NSArray * pickerList;
    IBOutlet UITextView * serviceRequestBody;
    IBOutlet UIActivityIndicatorView *spinner;
    IBOutlet UIButton * submitServiceRequest;
}

-(IBAction)submitServiceRequest:(id)sender;

@property (nonatomic, strong) User *currentUser;
@property (strong, nonatomic) UIPickerView *subjectPicker;

@end

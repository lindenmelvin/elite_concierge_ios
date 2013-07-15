//
//  ServiceRequestViewController.m
//  Elite Concierge
//
//  Created by Linden Melvin on 7/3/13.
//  Copyright (c) 2013 Linden Melvin. All rights reserved.
//

#import "ServiceRequestViewController.h"

@interface ServiceRequestViewController ()

@end

@implementation ServiceRequestViewController

@synthesize subjectPicker;
@synthesize currentUser;

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
	[self populatePicker];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

-(void)populatePicker {
    pickerList = [[NSArray alloc] initWithObjects:@"Plumbing", @"Electric", @"TV/Internet", @"Water", @"Garbage", @"Maintenance", @"Other", nil];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)subjectPicker
{
    //One column
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)subjectPicker numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    return pickerList.count;
}

-(NSString *)pickerView:(UIPickerView *)subjectPicker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //set item per row
    return [pickerList objectAtIndex:row];
}

-(IBAction)submitServiceRequest:(id)sender {
    NSInteger row;
    
    row = [subjectPicker selectedRowInComponent:0];
    NSString * subject = [pickerList objectAtIndex:row];
    
    NSString * body = serviceRequestBody.text;
    if([body isEqualToString:@""]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Please Provide Explanation"
                                                          message:@"You must provide an explanation."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        return;
    }
    [spinner startAnimating];
    [submitServiceRequest setEnabled:NO];
     NSString *fullPath = @"http://elite-concierge.herokuapp.com/api/service_requests.json";
    NSURL *url = [NSURL URLWithString:@"http://elite-concierge.herokuapp.com/service_requests"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:url];
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:
                            subject,@"service_request[subject]",
                            body,@"service_request[body]",
                            currentUser.authentication_token,@"auth_token",
                            nil];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:fullPath parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            NSLog(@"success");
            [spinner stopAnimating];
        }
                                         
        failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON) {
            NSLog(@"failure");
            [spinner stopAnimating];
            
        }];
    [operation start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

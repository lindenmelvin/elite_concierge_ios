//
//  MapViewController.h
//  Elite Concierge
//
//  Created by Linden Melvin on 7/14/13.
//  Copyright (c) 2013 Linden Melvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate> {
        MKMapView *mapView;
        UIToolbar *toolBar;
        IBOutlet UIBarButtonItem *zoom;
    IBOutlet UIBarButtonItem *type;
    }
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
- (IBAction)zoomIn:(UIBarButtonItem *)sender;
- (IBAction)changeType:(UIBarButtonItem *)sender;


@end

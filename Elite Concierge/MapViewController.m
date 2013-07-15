//
//  MapViewController.m
//  Elite Concierge
//
//  Created by Linden Melvin on 7/14/13.
//  Copyright (c) 2013 Linden Melvin. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView, toolBar;

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
    mapView.delegate = self; 
	mapView.showsUserLocation = YES;
    
    CLLocationCoordinate2D annotationCoord;
    
    annotationCoord.latitude = 34.083321;
    annotationCoord.longitude = -118.371909;
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = @"Your Building";
    annotationPoint.subtitle = @"Aka Danny Ross";
    [mapView addAnnotation:annotationPoint];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView
didUpdateUserLocation:
(MKUserLocation *)userLocation
{
    self.mapView.centerCoordinate =
    userLocation.location.coordinate;
}

- (void)zoomIn: (id)sender
{
    MKUserLocation *userLocation = mapView.userLocation;
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        userLocation.location.coordinate, 50, 50);
    [mapView setRegion:region animated:NO];
}

- (void) changeType: (id)sender
{
    if (mapView.mapType == MKMapTypeStandard)
        mapView.mapType = MKMapTypeSatellite;
    else
        mapView.mapType = MKMapTypeStandard;
}

@end

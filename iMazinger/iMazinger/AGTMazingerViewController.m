//
//  AGTMazingerViewController.m
//  iMazinger
//
//  Created by Roberto Halgravez on 7/6/17.
//  Copyright © 2017 Roberto Halgravez. All rights reserved.
//

#import "AGTMazingerViewController.h"


@interface AGTMazingerViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) id<MKAnnotation> model;

@end

@implementation AGTMazingerViewController

#pragma mark - Init
-(instancetype)initWithAnnotationObject:(id<MKAnnotation>)model {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.mapView addAnnotation:self.model];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    MKCoordinateRegion countryRegion = MKCoordinateRegionMakeWithDistance(self.model.coordinate, 1000000, 1000000);
    
    MKCoordinateRegion areaRegion = MKCoordinateRegionMakeWithDistance(self.model.coordinate, 500, 500);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mapView setRegion:countryRegion animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mapView setRegion:areaRegion animated:YES];
        });
    });
}

#pragma mark - Actions
- (IBAction)vectorial:(id)sender {
}

- (IBAction)satelite:(id)sender {
}

- (IBAction)hibrido:(id)sender {
}
@end

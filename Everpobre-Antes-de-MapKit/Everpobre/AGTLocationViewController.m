//
//  AGTLocationViewController.m
//  Everpobre
//
//  Created by Roberto Halgravez on 7/6/17.
//  Copyright © 2017 Agbo. All rights reserved.
//

#import "AGTLocationViewController.h"
#import "AGTLocation.h"

@interface AGTLocationViewController ()<MKMapViewDelegate>

@property(nonatomic, strong) AGTLocation *model;

@end

@implementation AGTLocationViewController

-(instancetype)initWithLocation:(AGTLocation *)location {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = location;
    }
    return self;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Crer un Annotation Object
    //Ya no necesitamos crear un annotation object porque ya tenemos AGTLoaction, sólo
    //hacemos que implemente el protocolo MKAnnotation
    
    //Pasarle ese annotation al mapView
    [self.mapView addAnnotation:self.model];
    
    //Region inicial
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.model.coordinate, 2000000, 2000000);
    [self.mapView setRegion:region];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //asinganr la region y animar
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.model.coordinate, 500, 500);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mapView setRegion:region animated:YES];
        });
    });
    
}

#pragma mark - Actions
- (IBAction)standardMap:(id)sender {
    self.mapView.mapType = MKMapTypeStandard;
}

- (IBAction)satelliteMap:(id)sender {
    self.mapView.mapType = MKMapTypeSatellite;
}

- (IBAction)hybridMap:(id)sender {
    self.mapView.mapType = MKMapTypeHybrid;
}

#pragma mark - MKMapViewDelegate
@end

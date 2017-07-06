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

#pragma mark - Actions
- (IBAction)vectorial:(id)sender {
}

- (IBAction)satelite:(id)sender {
}

- (IBAction)hibrido:(id)sender {
}
@end

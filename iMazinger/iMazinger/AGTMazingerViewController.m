//
//  AGTMazingerViewController.m
//  iMazinger
//
//  Created by Roberto Halgravez on 7/6/17.
//  Copyright © 2017 Roberto Halgravez. All rights reserved.
//

#import "AGTMazingerViewController.h"
#import <MapKit/MapKit.h>

@interface AGTMazingerViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation AGTMazingerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)vectorial:(id)sender {
}

- (IBAction)satelite:(id)sender {
}

- (IBAction)hibrido:(id)sender {
}
@end

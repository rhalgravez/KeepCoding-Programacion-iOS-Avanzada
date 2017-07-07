//
//  AGTLocationViewController.m
//  Everpobre
//
//  Created by Roberto Halgravez on 7/6/17.
//  Copyright © 2017 Agbo. All rights reserved.
//

#import "AGTLocationViewController.h"
#import "AGTLocation.h"

@interface AGTLocationViewController ()

@property(nonatomic, strong) AGTLocation *model;

@end

@implementation AGTLocationViewController

-(instancetype)initWithLocation:(AGTLocation *)location {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = location;
    }
    return self;
    
}


- (IBAction)standardMap:(id)sender {
}

- (IBAction)satelliteMap:(id)sender {
}

- (IBAction)hybridMap:(id)sender {
}
@end

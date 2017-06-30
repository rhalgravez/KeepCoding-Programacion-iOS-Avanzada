//
//  AGTPhotoViewController.m
//  Everpobre
//
//  Created by Roberto Halgravez on 6/30/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTPhotoViewController.h"
#import "AGTPhoto.h"

@interface AGTPhotoViewController () 

@property (nonatomic, strong) AGTPhoto *model;

@end

@implementation AGTPhotoViewController

#pragma mark - AGTDetailViewController
-(id)initWithModel:(id)model {
    
    NSAssert(model, @"Model can't be nil");
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
    }
    return self;
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.photoView.image = self.model.image;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.model.image = self.photoView.image;
}

#pragma mark - Actions

- (IBAction)takePhoto:(id)sender {
    
}

- (IBAction)deletePhoto:(id)sender {
}
@end

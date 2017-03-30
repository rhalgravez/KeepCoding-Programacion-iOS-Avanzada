//
//  AGTImageFilterOperation.m
//  Concurrencia II
//
//  Created by Roberto Manuel Halgravez Perea on 3/30/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTImageFilterOperation.h"
#import "AGTImageViewController.h"

@interface AGTImageFilterOperation ()

@property(strong, nonatomic) AGTImageViewController *imageViewController;

@end

@implementation AGTImageFilterOperation

-(instancetype)initWithImageViewController:(AGTImageViewController *) imageViewController {
    if (self = [super init]) {
        _imageViewController = imageViewController;
    }
    
    return self;
}

#pragma mark - Executing the Operation

-(void)main {
    //The filter is applied after the download so we need three things.
    
    //1) Update the viewController before going to background (show the activity indicator in the main thread)
    [self performSelectorOnMainThread:@selector(updateViewControllerBeforBackground) withObject:nil waitUntilDone:NO];
    
    //2) Apply the coreImage filter in background
    //2.1) Create context
    //2.2) Create CIImage from the original image
    //2.3) Create the filter
    //2.4) Create the outputImage (the image with the filter)
    //2.5) Create other filter (just for fun :D)
    //2.6) Create the outputImage (the image with the filter, again because we aply two filters)
    //2.7) Create the CGImage with the filters
    
    //3) Show the new image in main thread
    [self performSelectorOnMainThread:@selector(updateViewControllerAfterBackgroundWithImage:) withObject:image waitUntilDone:NO];
}

#pragma mark - Utils
-(void)updateViewControllerBeforBackground {
    [self.imageViewController.activityView startAnimating];
}

-(void) updateViewControllerAfterBackgroundWithImage:(UIImage *)image {
    [self.imageViewController.activityView stopAnimating];
    self.imageViewController.ImageView.image = image;
}



@end

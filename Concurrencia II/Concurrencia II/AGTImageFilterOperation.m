//
//  AGTImageFilterOperation.m
//  Concurrencia II
//
//  Created by Roberto Manuel Halgravez Perea on 3/30/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTImageFilterOperation.h"
#import "AGTImageViewController.h"

@import CoreImage;

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
    CIContext *context = [CIContext contextWithOptions:nil];
    //2.2) Create CIImage from the original image
    CIImage *ciImage = [CIImage imageWithCGImage:self.imageViewController.imageView.image.CGImage];
    //2.3) Create the filter
    CIFilter *falseColor = [CIFilter filterWithName:@"CIFalseColor"];
    [falseColor setDefaults];
    [falseColor setValue:ciImage forKey:kCIInputImageKey];
    //2.4) Create the outputImage (the image with the filter)
    CIImage *output = falseColor.outputImage;
    //2.5) Create other filter (just for fun :D)
    //2.6) Create the outputImage (the image with the filter, again because we aply two filters)
    //2.7) Create the CGImage with the filters
    CGImageRef res = [context createCGImage:output fromRect:[output extent]];
    
    //3) Show the new image in main thread
    [self performSelectorOnMainThread:@selector(updateViewControllerAfterBackgroundWithImage:) withObject:[UIImage imageWithCGImage:res] waitUntilDone:NO];
    
    //Free CGImageRef
    CGImageRelease(res);
}

#pragma mark - Utils
-(void)updateViewControllerBeforBackground {
    [self.imageViewController.activityView startAnimating];
}

-(void) updateViewControllerAfterBackgroundWithImage:(UIImage *)image {
    [self.imageViewController.activityView stopAnimating];
    self.imageViewController.imageView.image = image;
}



@end

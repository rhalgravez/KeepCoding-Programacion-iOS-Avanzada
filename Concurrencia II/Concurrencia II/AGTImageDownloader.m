//
//  AGTImageDownloader.m
//  Concurrencia II
//
//  Created by Roberto Manuel Halgravez Perea on 3/30/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTImageDownloader.h"
#import "AGTImageViewController.h"

@interface AGTImageDownloader()

@property(strong, nonatomic) AGTImageViewController *iVC;

@end

@implementation AGTImageDownloader

#pragma mark - Init
-(instancetype)initWithImageViewController:(AGTImageViewController *) vc {
    if (self = [super init]) {
        _iVC = vc;
    }
    
    return self;
}

#pragma mark - Executing the Operation
-(void)main {
    
    NSURL *url = [NSURL URLWithString:@"http://i.imgur.com/XXI53.jpg"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    //Next we need to send the image to the UIImageView in the main thread because this main methos is executed in the background thread
    [self performSelectorOnMainThread:@selector(updateViewControllerWithImage:) withObject:image waitUntilDone:NO];
}

#pragma mark - Utils
-(void)updateViewControllerWithImage:(UIImage *)image {
    
    self.iVC.imageView.image = image;
    [self.iVC.activityView stopAnimating];
}

@end

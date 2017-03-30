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

@end

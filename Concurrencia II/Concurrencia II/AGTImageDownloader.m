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

-(instancetype)initWithImageViewController:(AGTImageViewController *) vc {
    if (self = [super init]) {
        _iVC = vc;
    }
    
    return self;
}

@end

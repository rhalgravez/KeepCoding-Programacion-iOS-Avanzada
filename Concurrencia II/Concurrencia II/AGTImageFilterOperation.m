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

@property(strong, nonatomic) AGTImageViewController *vc;

@end

@implementation AGTImageFilterOperation

-(instancetype)initWithImageViewController:(AGTImageViewController *) vc {
    if (self = [super init]) {
        _vc = vc;
    }
    
    return self;
}

@end

//
//  AGTConnorMacLeod.m
//  Singleton
//
//  Created by Roberto Manuel Halgravez Perea on 3/29/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTConnorMacLeod.h"

@implementation AGTConnorMacLeod

+(instancetype) sharedConnorMacLeod {
    
    static dispatch_once_t onceToken;
    static AGTConnorMacLeod *shared;
    dispatch_once(&onceToken, ^{
        shared = [[AGTConnorMacLeod alloc] init];
    });
    
    return shared;
}

@end

//
//  AGTSystemSounds.m
//  AngryEsteban
//
//  Created by Roberto Manuel Halgravez Perea on 4/5/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTSystemSounds.h"

@implementation AGTSystemSounds

+(instancetype)sharedSystemSounds {
    static AGTSystemSounds *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[AGTSystemSounds alloc] init];
    });
    
    return shared;
}

@end

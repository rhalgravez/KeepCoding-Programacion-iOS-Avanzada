//
//  AGTSystemSounds.m
//  AngryEsteban
//
//  Created by Roberto Manuel Halgravez Perea on 4/5/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTSystemSounds.h"
@import AVFoundation;

@interface AGTSystemSounds ()

@property(strong, nonatomic) AVAudioPlayer *player;

@end

@implementation AGTSystemSounds

+(instancetype)sharedSystemSounds {
    static AGTSystemSounds *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[AGTSystemSounds alloc] init];
    });
    
    return shared;
}

#pragma mark - Sounds methods

-(void)punch {
    [self playFileName:@"punch" extension:@"wav" numberOfLopps:0];
    
}

-(void)startMachinGun {
    [self playFileName:@"machineGunLoop" extension:@"wav" numberOfLopps:-1];
}

-(void)stopMachinGun {
    [self.player stop];
}

-(void) tape {
    [self playFileName:@"tape" extension:@"caf" numberOfLopps:0];
}

-(void)untape {
    [self playFileName:@"untape" extension:@"caf" numberOfLopps:0];
}

-(void)binLaden {
    [self playFileName:@"niQueFueraYoBinLaden" extension:@"m4a" numberOfLopps:0];
}

#pragma mark - Util

-(void)playFileName:(NSString *)fileName extension:(NSString *)extension numberOfLopps:(NSInteger)loops {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:extension];
    
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (self.player) {
        self.player.numberOfLoops = loops;
        [self.player play];
    } else {
        NSLog(@"Error reading %@, error: %@", url, error);
    }
}
@end

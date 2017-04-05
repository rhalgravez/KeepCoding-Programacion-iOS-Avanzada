//
//  AGTSystemSounds.h
//  AngryEsteban
//
//  Created by Roberto Manuel Halgravez Perea on 4/5/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGTSystemSounds : NSObject

+(instancetype)sharedSystemSounds;

-(void)punch;
-(void)startMachinGun;
-(void)stopMachinGun;
-(void) tape;
-(void)untape;
-(void)binLaden;

@end

//
//  AGTMazingerZ.m
//  iMazinger
//
//  Created by Roberto Halgravez on 7/6/17.
//  Copyright © 2017 Roberto Halgravez. All rights reserved.
//

#import "AGTMazingerZ.h"

@implementation AGTMazingerZ

-(instancetype)init {
    if (self = [super init]) {
        _coordinate = CLLocationCoordinate2DMake(41.2827416, 1.32880926);
    }
    return self;
}

#pragma mark - MKAnnotation

@synthesize coordinate = _coordinate;

-(NSString*)title {
    return @"Estatua de Mazinger Z";
}

-(NSString *)subtitle {
    return @"Meca de frikis y otakus";
}

@end

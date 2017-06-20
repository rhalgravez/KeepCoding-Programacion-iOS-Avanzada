//
//  AGTColors.m
//  CollectionSample
//
//  Created by Roberto Halgravez on 6/20/17.
//  Copyright © 2017 Roberto Halgravez. All rights reserved.
//

#import "AGTColors.h"

@implementation AGTColors

-(UIColor *) randomColor {
    
    return [UIColor colorWithHue:[self randomFloat]
                      saturation:1.0
                      brightness:[self randomFloat]
                           alpha:[self randomFloat]];
}

-(float) randomFloat {
    return (arc4random() % 255) / 255.0f;
}

@end

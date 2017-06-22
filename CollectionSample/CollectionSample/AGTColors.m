//
//  AGTColors.m
//  CollectionSample
//
//  Created by Roberto Halgravez on 6/20/17.
//  Copyright © 2017 Roberto Halgravez. All rights reserved.
//

#import "AGTColors.h"

@implementation AGTColors

-(UIColor *)colorInGradientAt:(NSUInteger)current to:(NSUInteger)maximum {
    
    float currentHue = (current * 1.0f) / (maximum * 1.0f);
    
    return [UIColor colorWithHue:currentHue saturation:1.0 brightness:0.8 alpha:1.0];
}

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

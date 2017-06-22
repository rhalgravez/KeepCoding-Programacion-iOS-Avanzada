//
//  AGTColors.h
//  CollectionSample
//
//  Created by Roberto Halgravez on 6/20/17.
//  Copyright © 2017 Roberto Halgravez. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface AGTColors : NSObject

-(UIColor *)colorInGradientAt:(NSUInteger)current to:(NSUInteger)maximum;
-(UIColor *) randomColor;

@end

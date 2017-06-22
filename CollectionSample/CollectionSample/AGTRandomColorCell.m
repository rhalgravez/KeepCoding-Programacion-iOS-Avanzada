//
//  AGTRandomColorCell.m
//  CollectionSample
//
//  Created by Roberto Halgravez on 6/22/17.
//  Copyright © 2017 Roberto Halgravez. All rights reserved.
//

#import "AGTRandomColorCell.h"
#import "UIColor+Colorful.h"

@implementation AGTRandomColorCell

-(void)awakeFromNib {
    self.shouldAnimateChangeOfColor = NO;
    [self setupKVO];
}

-(void) dealloc {
    [self tearDownKVO];
}

#pragma mark - View lifecycle
-(void)prepareForReuse {
    [super prepareForReuse];
    
    self.shouldAnimateChangeOfColor = NO;
    self.color = [UIColor x11WhiteColor];
}

#pragma mark - KVO
-(void)setupKVO {
    [self addObserver:self forKeyPath:@"color" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

-(void)tearDownKVO {
    [self removeObserver:self forKeyPath:@"color"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context {
    self.hexView.text = [self.color hexString];
    
    float  duration = 0.0f;
    if (self.shouldAnimateChangeOfColor) {
        duration = 0.6f;
    }
    
    [UIView animateWithDuration:duration animations:^{
        self.backgroundColor = self.color;
        self.hexView.textColor = [self.color contrastingTextColor];
    }];
    
    self.shouldAnimateChangeOfColor = YES;
}

@end

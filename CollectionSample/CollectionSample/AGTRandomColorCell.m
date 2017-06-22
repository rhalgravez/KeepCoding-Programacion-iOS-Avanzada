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
    [self setupKVO];
}

-(void) dealloc {
    [self tearDownKVO];
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
    
    [UIView animateWithDuration:0.6 animations:^{
        self.backgroundColor = self.color;
        self.hexView.textColor = [self.color contrastingTextColor];
    }];
}

@end

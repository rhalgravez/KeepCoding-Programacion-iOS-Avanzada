//
//  AGTColorfulViewController.m
//  CollectionSample
//
//  Created by Roberto Halgravez on 6/20/17.
//  Copyright © 2017 Roberto Halgravez. All rights reserved.
//

#import "AGTColorfulViewController.h"
#import "AGTColors.h"

@interface AGTColorfulViewController ()

@property (strong, nonatomic) AGTColors *model;

@end

@implementation AGTColorfulViewController

#pragma mark - Init
-(instancetype)initWithModel:(AGTColors *)model layout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        _model = model;
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

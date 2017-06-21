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

+(NSString *)randomColorCellIdentifier;

@end

@implementation AGTColorfulViewController

#pragma mark - Class methods
+(NSString *)randomColorCellIdentifier {//Smalltalk way to create a constant
    return @"randomColorCell";
}

#pragma mark - Init
-(instancetype)initWithModel:(AGTColors *)model layout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        _model = model;
    }
    
    return self;
}

#pragma mark - VIew lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self registerRandomColorCell];
}


#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils
-(void)registerRandomColorCell {
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[AGTColorfulViewController randomColorCellIdentifier]];
}

@end

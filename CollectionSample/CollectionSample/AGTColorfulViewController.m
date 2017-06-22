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
+(NSString *)gradientColorCellIdentifier;

+(NSInteger)maxRandomColorsToDisplay;
+(NSInteger)maxGradientColorsToDisplay;

+(NSUInteger)radomColorSection;
+(NSUInteger)gradientColorSection;

@end

@implementation AGTColorfulViewController

#pragma mark - Class methods
+(NSString *)randomColorCellIdentifier {//Smalltalk way to create a constant
    return @"randomColorCell";
}

+(NSInteger)maxRandomColorsToDisplay {
    return 104;
}

+(NSInteger)maxGradientColorsToDisplay {
    return 104;
}

+(NSString *)gradientColorCellIdentifier {
    return @"gradientColorCell";
}

+(NSUInteger)radomColorSection {
    return 1;
}
+(NSUInteger)gradientColorSection {
    return 0;
}

#pragma mark - Init
-(instancetype)initWithModel:(AGTColors *)model layout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        _model = model;
        self.title = @"United colors of Agbo";
    }
    
    return self;
}

#pragma mark - VIew lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self registerRandomColorCell];
    [self registerGradientColorCell];
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

-(void)registerGradientColorCell {
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[AGTColorfulViewController gradientColorCellIdentifier]];
}

#pragma mark - Data Source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [AGTColorfulViewController maxRandomColorsToDisplay];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AGTColorfulViewController randomColorCellIdentifier] forIndexPath:indexPath];
    
    cell.backgroundColor = [self.model randomColor];
    
    return cell;
}

@end

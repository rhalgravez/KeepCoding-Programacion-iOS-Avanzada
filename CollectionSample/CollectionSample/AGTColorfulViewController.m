//
//  AGTColorfulViewController.m
//  CollectionSample
//
//  Created by Roberto Halgravez on 6/20/17.
//  Copyright © 2017 Roberto Halgravez. All rights reserved.
//

#import "AGTColorfulViewController.h"
#import "AGTColors.h"
#import "AGTRandomColorCell.h"

@interface AGTColorfulViewController ()

@property (strong, nonatomic) AGTColors *model;
@property (nonatomic) NSInteger maxRandomColorsToDisplay;

+(NSString *)randomColorCellIdentifier;
+(NSString *)gradientColorCellIdentifier;
+(NSString *)sectionHeaderIdentifier;

+(NSInteger)maxGradientColorsToDisplay;

+(NSUInteger)radomColorSection;
+(NSUInteger)gradientColorSection;

@end

@implementation AGTColorfulViewController

#pragma mark - Class methods
+(NSString *)randomColorCellIdentifier {//Smalltalk way to create a constant
    return @"randomColorCell";
}

+(NSInteger)maxGradientColorsToDisplay {
    return 104;
}

+(NSString *)gradientColorCellIdentifier {
    return @"gradientColorCell";
}

+(NSUInteger)radomColorSection {
    return 0;
}
+(NSUInteger)gradientColorSection {
    return 1;
}

+(NSString *)sectionHeaderIdentifier {
    return @"SectionHeader";
}

#pragma mark - Init
-(instancetype)initWithModel:(AGTColors *)model layout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        _model = model;
        self.title = @"United colors of Agbo";
        self.maxRandomColorsToDisplay = 3;
    }
    
    return self;
}

#pragma mark - VIew lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self registerRandomColorCell];
    [self registerGradientColorCell];
    [self registerSectionHedearView];
    
    //Create button to add random colors
    UIBarButtonItem *addColor = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewRandomColor:)];
    
    self.navigationItem.rightBarButtonItem = addColor;
}


#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils
-(void)registerRandomColorCell {
    //Read the nib
    UINib *nib = [UINib nibWithNibName:@"AGTRandomColorCell" bundle:nil];
    
    //Register the nib
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:[AGTColorfulViewController randomColorCellIdentifier]];
}

-(void)registerGradientColorCell {
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[AGTColorfulViewController gradientColorCellIdentifier]];
}

-(void)registerSectionHedearView {
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[AGTColorfulViewController sectionHeaderIdentifier]];
}

#pragma mark - Actions
-(void)addNewRandomColor:(id)sender {
    self.maxRandomColorsToDisplay = self.maxRandomColorsToDisplay + 1;
    
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:[AGTColorfulViewController radomColorSection]]]];
    
}

#pragma mark - Data Source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == [AGTColorfulViewController radomColorSection]) {
        return self.maxRandomColorsToDisplay;

    } else {
        return [AGTColorfulViewController maxGradientColorsToDisplay];
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == [AGTColorfulViewController radomColorSection]) {
        AGTRandomColorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AGTColorfulViewController randomColorCellIdentifier] forIndexPath:indexPath];
        cell.color = [self.model randomColor];
        
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AGTColorfulViewController gradientColorCellIdentifier] forIndexPath:indexPath];
        
        cell.backgroundColor = [self.model colorInGradientAt:indexPath.item to:[AGTColorfulViewController maxGradientColorsToDisplay]];
    
        return cell;
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *subView;
    
    if(kind == UICollectionElementKindSectionHeader) {
        //REcycle header, configure it and return
        subView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[AGTColorfulViewController sectionHeaderIdentifier] forIndexPath:indexPath];
        
        subView.backgroundColor = [UIColor colorWithWhite:0.65 alpha:1.0];
        
        for (UIView *each in subView.subviews) {
            [each removeFromSuperview];
        }
        
        UILabel *title = [[UILabel alloc] initWithFrame:subView.bounds];
        title.textColor = [UIColor whiteColor];
        [subView addSubview:title];
        
        if (indexPath.section == [AGTColorfulViewController gradientColorSection]) {
            title.text = @"Gradient";
        } else {
            title.text = @"Random";
        }
    }
    return subView;
}

@end

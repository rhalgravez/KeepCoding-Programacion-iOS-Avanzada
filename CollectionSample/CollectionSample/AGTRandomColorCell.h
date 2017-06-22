//
//  AGTRandomColorCell.h
//  CollectionSample
//
//  Created by Roberto Halgravez on 6/22/17.
//  Copyright © 2017 Roberto Halgravez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGTRandomColorCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *hexView;

@property (nonatomic, strong) UIColor *color;

@end

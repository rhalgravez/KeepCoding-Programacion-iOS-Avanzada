//
//  AGTColorfulViewController.h
//  CollectionSample
//
//  Created by Roberto Halgravez on 6/20/17.
//  Copyright © 2017 Roberto Halgravez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTColors;

@interface AGTColorfulViewController : UICollectionViewController

-(instancetype)initWithModel:(AGTColors *)model layout:(UICollectionViewLayout *)layout;

@end

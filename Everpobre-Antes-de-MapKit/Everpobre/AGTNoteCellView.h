//
//  AGTNoteCellView.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 16/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTNote;

@interface AGTNoteCellView : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *locationView;

-(void) observeNote:(AGTNote *) note;

@end

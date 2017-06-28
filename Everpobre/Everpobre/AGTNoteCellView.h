//
//  AGTNoteCellView.h
//  Everpobre
//
//  Created by Roberto Halgravez on 6/22/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTNote;

@interface AGTNoteCellView : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDAteView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

-(void)observeNote:(AGTNote *) note;

@end

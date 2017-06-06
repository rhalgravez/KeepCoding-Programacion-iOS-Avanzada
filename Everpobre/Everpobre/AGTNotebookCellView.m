//
//  AGTNotebookCellView.m
//  Everpobre
//
//  Created by Roberto Halgravez on 6/6/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTNotebookCellView.h"

@implementation AGTNotebookCellView

#pragma mark - Class methods

+(NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

+(CGFloat)cellHeight {
    return 60;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

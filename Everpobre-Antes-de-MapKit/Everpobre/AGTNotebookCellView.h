//
//  AGTNotebookCellView.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 10/04/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGTNotebookCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfNotesView;

+(NSString *)cellId;
+(CGFloat)cellHeight;

@end

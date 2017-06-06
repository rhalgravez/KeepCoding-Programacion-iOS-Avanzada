//
//  AGTNotebookCellView.h
//  Everpobre
//
//  Created by Roberto Halgravez on 6/6/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGTNotebookCellView : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameView;
@property (nonatomic, strong) IBOutlet UILabel *numberOfNotesView;

@end

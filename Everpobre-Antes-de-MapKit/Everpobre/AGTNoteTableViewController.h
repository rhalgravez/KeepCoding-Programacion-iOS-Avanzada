//
//  AGTNoteTableViewController.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 19/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AGTDetailViewController.h"

@class AGTNote;

@interface AGTNoteTableViewController : UITableViewController<AGTDetailViewController>

-(id) initWithModel:(AGTNote*) model
              style:(UITableViewStyle) style;

@end

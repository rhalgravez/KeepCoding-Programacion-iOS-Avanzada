//
//  AGTNotesTableViewController.h
//  Everpobre
//
//  Created by Roberto Halgravez on 6/28/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"
@class AGTNotebook;

@interface AGTNotesTableViewController : AGTCoreDataTableViewController

-(instancetype)initWithNotebook:(AGTNotebook *)notebook;

@end

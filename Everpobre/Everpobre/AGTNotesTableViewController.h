//
//  AGTNotesTableViewController.h
//  Everpobre
//
//  Created by Roberto Halgravez on 6/9/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"
#import "AGTNotebook.h"

@interface AGTNotesTableViewController : AGTCoreDataTableViewController

-(instancetype)initWithNotebook:(AGTNotebook *)notebook;

@end

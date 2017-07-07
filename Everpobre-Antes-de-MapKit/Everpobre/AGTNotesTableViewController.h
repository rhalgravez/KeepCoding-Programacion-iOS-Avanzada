//
//  AGTNotesTableViewController.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 15/04/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"
@class AGTNotebook;

@interface AGTNotesTableViewController : AGTCoreDataTableViewController

-(id) initWithNotebook:(AGTNotebook *)notebook;

@end

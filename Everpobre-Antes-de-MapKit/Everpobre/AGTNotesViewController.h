//
//  AGTNotesViewController.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 17/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "AGTCoreDataCollectionViewController.h"
@class AGTNotebook;

@interface AGTNotesViewController : AGTCoreDataCollectionViewController
@property (nonatomic, strong) AGTNotebook *notebook;

@end

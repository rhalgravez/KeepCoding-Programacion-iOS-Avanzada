//
//  AGTNotesViewController.h
//  Everpobre
//
//  Created by Roberto Halgravez on 6/28/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTCoreDataCollectionViewController.h"

@class AGTNotebook;

@interface AGTNotesViewController : AGTCoreDataCollectionViewController

@property(nonatomic, strong) AGTNotebook *notebook;

@end

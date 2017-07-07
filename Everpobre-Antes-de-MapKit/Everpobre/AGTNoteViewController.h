//
//  AGTNoteViewController.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 18/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGTDetailViewController.h"

@class AGTNote;
@class AGTNotebook;

@interface AGTNoteViewController : UIViewController<AGTDetailViewController>
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

-(id) initForNewNoteInNotebook: (AGTNotebook*) notebook;



@end

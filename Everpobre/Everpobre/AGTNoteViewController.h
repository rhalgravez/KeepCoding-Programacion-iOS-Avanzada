//
//  AGTNoteViewController.h
//  Everpobre
//
//  Created by Roberto Halgravez on 6/29/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AGTDetailViewController.h"

@class AGTNote;
@class AGTNotebook;

@interface AGTNoteViewController : UIViewController <AGTDetailViewController>

@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

-(instancetype)initForNewNoteInNotebook:(AGTNotebook*)notebook;

@end

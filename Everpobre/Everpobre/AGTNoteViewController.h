//
//  AGTNoteViewController.h
//  Everpobre
//
//  Created by Roberto Halgravez on 6/29/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AGTNoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

//
//  AGTMazingerViewController.h
//  iMazinger
//
//  Created by Roberto Halgravez on 7/6/17.
//  Copyright © 2017 Roberto Halgravez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AGTMazingerViewController : UIViewController

-(instancetype)initWithAnnotationObject:(id<MKAnnotation>)model;

@end

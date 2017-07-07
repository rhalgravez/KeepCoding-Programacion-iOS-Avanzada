//
//  AGTLocationViewController.h
//  Everpobre
//
//  Created by Roberto Halgravez on 7/6/17.
//  Copyright © 2017 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTLocation;

@interface AGTLocationViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)standardMap:(id)sender;
- (IBAction)satelliteMap:(id)sender;
- (IBAction)hybridMap:(id)sender;

-(instancetype)initWithLocation:(AGTLocation *)location;



@end

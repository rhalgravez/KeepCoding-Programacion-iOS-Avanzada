//
//  AGTPhotoViewController.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 22/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGTDetailViewController.h"

@interface AGTPhotoViewController : UIViewController<AGTDetailViewController>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
- (IBAction)takePicture:(id)sender;
- (IBAction)deletePhoto:(id)sender;
- (IBAction)applyVintageEffect:(id)sender;
- (IBAction)zoomToFace:(id)sender;

@end

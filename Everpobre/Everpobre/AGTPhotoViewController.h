//
//  AGTPhotoViewController.h
//  Everpobre
//
//  Created by Roberto Halgravez on 6/30/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGTPhotoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

- (IBAction)takePhoto:(id)sender;
- (IBAction)deletePhoto:(id)sender;

@end

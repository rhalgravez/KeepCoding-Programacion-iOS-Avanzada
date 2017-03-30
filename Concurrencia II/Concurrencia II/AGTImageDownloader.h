//
//  AGTImageDownloader.h
//  Concurrencia II
//
//  Created by Roberto Manuel Halgravez Perea on 3/30/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AGTImageViewController;

@interface AGTImageDownloader : NSOperation

-(instancetype)initWithImageViewController:(AGTImageViewController *) vc;

@end

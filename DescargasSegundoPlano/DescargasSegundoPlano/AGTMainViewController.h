//
//  AGTMainViewController.h
//  DescargasSegundoPlano
//
//  Created by Roberto Manuel Halgravez Perea on 3/31/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGTMainViewController : UIViewController <NSURLSessionDownloadDelegate>

@property (copy, nonatomic) void (^sessionCompletionHandler)(void);

@end

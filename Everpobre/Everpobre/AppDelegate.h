//
//  AppDelegate.h
//  Everpobre
//
//  Created by Roberto Manuel Halgravez Perea on 4/10/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGTSimpleCoreDataStack;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AGTSimpleCoreDataStack *model;


@end


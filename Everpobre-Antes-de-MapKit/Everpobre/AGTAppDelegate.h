//
//  AGTAppDelegate.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 01/02/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGTSimpleCoreDataStack;

@interface AGTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AGTSimpleCoreDataStack *model;


@end

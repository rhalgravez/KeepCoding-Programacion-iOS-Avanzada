//
//  UIViewController+Navigation.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 03/04/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

-(UINavigationController *)wrappedInNavigation{
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    
    return nav;
}
@end

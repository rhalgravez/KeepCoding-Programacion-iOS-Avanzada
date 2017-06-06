//
//  UIViewController+Navigation.m
//  Everpobre
//
//  Created by Roberto Halgravez on 6/6/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

-(UINavigationController *)wrappedInNavigation {
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self];
    
    return navController;
}

@end

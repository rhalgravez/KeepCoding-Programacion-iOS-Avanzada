//
//  AppDelegate.m
//  DescargasSegundoPlano
//
//  Created by Roberto Manuel Halgravez Perea on 3/31/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTMainViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic) AGTMainViewController *mainVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.mainVC = [[AGTMainViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:self.mainVC];
    
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler {
    //Nos han despertado de nuestro sueño en background para gestionar
    //alguna descarga en 2do plano: o ha trminado, o necesita algún tipo de credencial.
    //Guardamos el completionhander y lo llamaremos cuando terminemos de recibir
    //mensajes de delegado
    self.mainVC.sessionCompletionHandler = completionHandler;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

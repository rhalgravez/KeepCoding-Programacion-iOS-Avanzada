//
//  AppDelegate.m
//  Everpobre
//
//  Created by Roberto Manuel Halgravez Perea on 4/10/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTSimpleCoreDataStack.h"
#import "AGTNotebook.h"
#import "AGTNote.h"
#import "Settings.h"
#import "AGTNotebooksViewController.h"
#import "UIViewController+Navigation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.model = [AGTSimpleCoreDataStack coreDataStackWithModelName:@"Model"];
    
    [self trastearConDatos];
    [self predicateTest];
    [self autoSave];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:[AGTNotebook entityName]];
    
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:[AGTNamedEntityAttributes modificationDate]
                                                              ascending:NO],
                                [NSSortDescriptor sortDescriptorWithKey:[AGTNamedEntityAttributes name]
                                                              ascending:YES]];
    
    NSFetchedResultsController *fetchResultsC = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                    managedObjectContext:self.model.context
                                                                                      sectionNameKeyPath:nil
                                                                                               cacheName:nil];
    
    AGTNotebooksViewController *notebookVC = [[AGTNotebooksViewController alloc] initWithFetchedResultsController:fetchResultsC
                                                                                                            style:UITableViewStylePlain];
    
    self.window.rootViewController = [notebookVC wrappedInNavigation];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    [self save];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self save];
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

#pragma mark - Utils
-(void) addDummyData{
    
    [self.model zapAllData];
    
    AGTNotebook *novias = [AGTNotebook notebookWithName:@"Ex-novias para el recuerdo"
                                                context:self.model.context];
    
    [AGTNote noteWithName:@"Camila Dávalos"
                 notebook:novias
                  context:self.model.context];
    
    [AGTNote noteWithName:@"Mariana Dávalos"
                 notebook:novias
                  context:self.model.context];
    
    [AGTNote noteWithName:@"Pampita"
                 notebook:novias
                  context:self.model.context];
    
    AGTNotebook *lugares = [AGTNotebook notebookWithName:@"Lugares donde me han pasado cosas raras"
                                                 context:self.model.context];
    
    [AGTNote noteWithName:@"Puerta del Sol"
                 notebook:lugares
                  context:self.model.context];
    [AGTNote noteWithName:@"Tatooine"
                 notebook:lugares
                  context:self.model.context];
    [AGTNote noteWithName:@"Dantooine"
                 notebook:lugares
                  context:self.model.context];
    [AGTNote noteWithName:@"Solaria"
                 notebook:lugares
                  context:self.model.context];
    
    // Guardamos
    [self save];
    
}

-(void)trastearConDatos {
    
    [self addDummyData];
    
    // Buscar
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[AGTNote entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AGTNamedEntityAttributes.name
                                                          ascending:YES],
                            [NSSortDescriptor sortDescriptorWithKey:AGTNamedEntityAttributes.modificationDate
                                                          ascending:NO]];
    NSError *error = nil;
    NSArray *results = [self.model.context executeFetchRequest:req
                                                         error:&error];
    
    if (results == nil) {
        NSLog(@"Error al buscar: %@", results);
    }else{
        NSLog(@"Results %@", results);
    }
    
}

-(void)save {
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar %s \n\n %@", __func__, error);
    }];
}

-(void)autoSave {
    
    if (AUTO_SAVE) {
        NSLog(@"Saving...");
        [self save];
        [self performSelector:@selector(autoSave) withObject:nil afterDelay:AUTO_SAVE_DELAY_IN_SECONDS];
    }
}

#pragma mark - Predicate Playground
-(void)predicateTest {
    
    //Obtenemos las novias para el recuerdo
    NSPredicate *novias = [NSPredicate predicateWithFormat:@"notebook.name ==[cd] 'Ex-novias para el recuerdo'"];
    
    //Fetch request
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[AGTNote entityName]];
    NSArray *results = nil;
    
    //Ex-Novias
    request.predicate = novias;
    results = [self.model executeRequest:request withError:^(NSError *error) {
        NSLog(@"Error buscando %@", request);
    }];
    
    NSLog(@"Results: \n %@", results);
    
    //Obtener las Dávalos
    NSPredicate *davalos = [NSCompoundPredicate andPredicateWithSubpredicates:@[novias, [NSPredicate predicateWithFormat:@"name ENDSWITH[cd] 'davalos'"]]];
    
    request.predicate = davalos;
    results = [self.model executeRequest:request withError:^(NSError *error) {
        NSLog(@"Error buscando %@", request);
    }];
    
    NSLog(@"Results Davalos: \n %@", results);
    
    //Obtener Pampita
    NSPredicate *pampita = [NSCompoundPredicate andPredicateWithSubpredicates:@[novias,[NSPredicate predicateWithFormat:@"name CONTAINS[cd] 'pampita'"]]];
    
    request.predicate = pampita;
    results = [self.model executeRequest:request withError:^(NSError *error) {
        NSLog(@"Error buscando %@", request);
    }];
    
    NSLog(@"Results Pampita: \n %@", results);
}

@end

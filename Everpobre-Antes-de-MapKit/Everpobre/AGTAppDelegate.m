//
//  AGTAppDelegate.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 01/02/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "AGTAppDelegate.h"
#import "AGTSimpleCoreDataStack.h"

#import "AGTNotebook.h"
#import "AGTNote.h"
#import "AGTLocation.h"
#import "AGTNotebooksViewController.h"
#import "UIViewController+Navigation.h"

@implementation AGTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Crear una instancia del stack de Core Data
    self.model = [AGTSimpleCoreDataStack coreDataStackWithModelName:@"Model"];
    
    // ¿Añadimos datos chorras?
    if (ADD_DUMMY_DATA) {
        [self addDummyData];

    }
    
    
    // Iniciamos el inspector del contexto
    [self printContextState];
    
    // Iniciamos el autoguardar
    [self autoSave];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGTNotebook entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AGTNamedEntityAttributes.modificationDate
                                                          ascending:NO],
                            [NSSortDescriptor sortDescriptorWithKey:AGTNamedEntityAttributes.name
                                                          ascending:YES]];
    req.fetchBatchSize = 20;
    
    
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                              managedObjectContext:self.model.context
                                                                                sectionNameKeyPath:nil
                                                                                         cacheName:nil];
    
    AGTNotebooksViewController *nbVC = [[AGTNotebooksViewController alloc]
                                        initWithFetchedResultsController:results
                                        style:UITableViewStylePlain];
    
    
    self.window.rootViewController = [nbVC wrappedInNavigation];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"Adiós, mundo cruel");
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
-(void) trastearConDatos{
    
    // Añadir
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


-(void)save{
    
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar %s \n\n %@", __func__, error);
    }];
}

-(void)autoSave{
    
    if (AUTO_SAVE) {
        NSLog(@"Autoguardando....");
        
        [self save];
        [self performSelector:@selector(autoSave)
                   withObject:nil
                   afterDelay:AUTO_SAVE_DELAY_IN_SECONDS];
        
        
    }
}



#pragma mark - Predicate Playground
-(void)predicateTest{
    
    // Obtenemos las novias para el recuerdo
    NSPredicate *novias = [NSPredicate predicateWithFormat:@"notebook.name == 'Ex-novias para el recuerdo'"];
    NSPredicate *davalos = [NSCompoundPredicate andPredicateWithSubpredicates:@[novias,[NSPredicate predicateWithFormat:@"name ENDSWITH[cd] 'davalos' "]]];
    NSPredicate *pampita = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] 'pampita'"];
    
    // Las novias
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGTNote entityName]];
    req.predicate = novias;
    
    NSArray *res = [self.model executeRequest:req
                                    withError:^(NSError *error) {
                                        NSLog(@"Error al buscar %@", req);
                                    }];
    
    NSLog(@"Novias:\n %@", res);
    
    // Las dávalos
    req.predicate = davalos;
    res = [self.model executeRequest:req
                           withError:^(NSError *error) {
                               NSLog(@"Error al buscar %@", req);
                           }];
    
    NSLog(@"Dávalos:\n %@", res);
    
    // Pampita
    req.predicate = pampita;
    res = [self.model executeRequest:req
                           withError:^(NSError *error) {
                               NSLog(@"Error al buscar %@", req);
                           }];

    NSLog(@"Pampita:\n %@", res);
}


-(void) printContextState{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGTNotebook entityName]];
    NSUInteger numNotebooks = [[self.model executeRequest:req
                                         withError:nil] count];
    
    req = [NSFetchRequest fetchRequestWithEntityName:[AGTNote entityName]];
    NSUInteger numNotes = [[self.model executeRequest:req
                                     withError:nil] count];
    
    req = [NSFetchRequest fetchRequestWithEntityName:[AGTLocation entityName]];
    NSUInteger numLocations = [[self.model executeRequest:req
                                         withError:nil] count];
    
    printf("----------------------------------------------------\n");
    printf("Total number of objects:    %lu\n", (unsigned long)self.model.context.registeredObjects.count);
    printf("Number of notebooks:        %lu\n", (unsigned long)numNotebooks);
    printf("Number of notes:            %lu\n", (unsigned long)numNotes);
    printf("Number of locations:        %lu\n", (unsigned long)numLocations);
    printf("----------------------------------------------------\n\n\n");
    
    [self performSelector:@selector(printContextState)
               withObject:nil
               afterDelay:5];
    
}




























@end

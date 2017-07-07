//
//  AGTNotebooksViewController.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 02/04/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "AGTNotebooksViewController.h"
#import "AGTNotebook.h"
#import "AGTNotebookCellView.h"
#import "AGTNotesTableViewController.h"
#import "AGTNotesViewController.h"
#import "AGTNote.h"

@interface AGTNotebooksViewController ()

@end

@implementation AGTNotebooksViewController

#pragma mark - View Lifecycle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = @"Everpobre";
    
    
    // Crear un botón, con un target y un action
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(addNotebook:)];
    
    
    // lo añadimos a la barra de navegación
    self.navigationItem.rightBarButtonItem = addButton;
    
    // Botón de editar
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
 
    // Alta en notificacion de sensor de proximidad
    if (UNDO_WITH_PROXIMITY_SENSOR) {
        [self setupProximitySensor];
    }
    
    
    // Registrar el nib de la celda personalizada
    UINib *cellNib = [UINib nibWithNibName:@"AGTNotebookCellView"
                                    bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:[AGTNotebookCellView cellId]];
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Baja en todas las notificaciones
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

#pragma mark - Actions
-(void)addNotebook:(id) sender{
    
    // nueva instancia de AGTNotebook
    [AGTNotebook notebookWithName:@"New Notebook"
                          context:self.fetchedResultsController.managedObjectContext];
    
    
}
#pragma mark - Data Source
-(void) tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AGTNotebook *del = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.fetchedResultsController.managedObjectContext deleteObject:del];
    }
}
-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguar el notebook
    AGTNotebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    // Crear una celda
    AGTNotebookCellView *cell = [tableView dequeueReusableCellWithIdentifier:[AGTNotebookCellView cellId]];
    
    
    // Sincronizar libreta -> celda
    cell.nameView.text = nb.name;
    cell.numberOfNotesView.text = [NSString stringWithFormat:@"%lu", (unsigned long)nb.notes.count];
    
    // Devolver la celda
    return cell;
}


#pragma mark - TableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [AGTNotebookCellView cellHeight];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // Fetch request
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGTNote entityName]];
    req.sortDescriptors = @[[NSSortDescriptor
                             sortDescriptorWithKey:AGTNamedEntityAttributes.name
                             ascending:YES],
                            [NSSortDescriptor
                             sortDescriptorWithKey:AGTNamedEntityAttributes.modificationDate
                             ascending:NO],
                            [NSSortDescriptor
                             sortDescriptorWithKey:AGTNamedEntityAttributes.creationDate
                             ascending:NO]];
    req.fetchBatchSize = 20;
    
    req.predicate = [NSPredicate predicateWithFormat:@"notebook == %@", [self.fetchedResultsController objectAtIndexPath:indexPath]];
    
    // Fetched Results Controller
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:self.fetchedResultsController.managedObjectContext
                                      sectionNameKeyPath:nil
                                      cacheName:nil];
    
    // layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(140, 150);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // View controller
    AGTNotesViewController *nb = [AGTNotesViewController coreDataCollectionViewControllerWithFetchedResultsController:fc
                                                                                                               layout:layout];
    
    nb.notebook = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Push it!
    [self.navigationController pushViewController:nb
                                         animated:YES];
    
}
#pragma mark - Proximity Sensor
-(void)setupProximitySensor{
    
    UIDevice *dev = [UIDevice currentDevice];
    
    if ([self hasProximitySensor]) {
        [dev setProximityMonitoringEnabled:YES];
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        [center addObserver:self
                   selector:@selector(proximityStateDidChange:)
                       name:UIDeviceProximityStateDidChangeNotification
                     object:nil];
        
    }

}
-(BOOL)hasProximitySensor{
    
    UIDevice *dev =[UIDevice currentDevice];
    BOOL oldValue = [dev isProximityMonitoringEnabled];
    [dev setProximityMonitoringEnabled:!oldValue];
    BOOL newValue = [dev isProximityMonitoringEnabled];
    
    [dev setProximityMonitoringEnabled:oldValue];
    
    return (oldValue != newValue);
}

// UIDeviceProximityStateDidChangeNotification
-(void) proximityStateDidChange:(NSNotification *) notification{
    
    [self.fetchedResultsController.managedObjectContext.undoManager undo];
    
}





@end














//
//  AGTNotebooksViewController.m
//  Everpobre
//
//  Created by Roberto Halgravez on 6/5/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTNotebooksViewController.h"
#import "AGTNotebook.h"

@interface AGTNotebooksViewController ()

@end

@implementation AGTNotebooksViewController

#pragma mark - View Lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Everpobre";
    
    //Create button with target and action
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNotebook:)];
    
    //Add button to the navigation bar
    self.navigationItem.rightBarButtonItem = addButton;
    
    //Edit button
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //Register for the proximity sensor notification
    UIDevice *device = [UIDevice currentDevice];
    if ([self hasProximitySensor]) {
        [device setProximityMonitoringEnabled:YES];
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(proximityStateDidChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

#pragma mark - Actions
-(void)addNotebook:(id)sender {
    //What we need if we want to create a noebook and show it
    //1)Create new AGTNotebook instance
    [AGTNotebook notebookWithName:@"New Notebook" context:self.fetchedResultsController.managedObjectContext];
}

#pragma mark - Data Source
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Find out which notbook
    AGTNotebook *notebook = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Create cell
    static NSString *cellIdentifier = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    //Sync botebook with the cell
    cell.textLabel.text = notebook.name;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateStyle = NSDateFormatterMediumStyle;
    cell.detailTextLabel.text = [format stringFromDate:notebook.modificationDate];
    
    //Return cell
    return cell;
}

-(void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //Find out which notebook i have to delete
        AGTNotebook *notebook = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        //Delete the notebook from the model
        [self.fetchedResultsController.managedObjectContext deleteObject:notebook];
    }
}

#pragma mark - Proximity Sensor

-(BOOL)hasProximitySensor {
    UIDevice *device = [UIDevice currentDevice];
    BOOL oldValue = [device isProximityMonitoringEnabled];
    [device setProximityMonitoringEnabled:!oldValue];
    BOOL newValue = [device isProximityMonitoringEnabled];
    
    [device setProximityMonitoringEnabled:oldValue];
    
    return (oldValue != newValue);
}

//UIDeviceProximityStateDidChangeNotification
-(void)proximityStateDidChange:(NSNotification *)notification {
    
    [self.fetchedResultsController.managedObjectContext.undoManager undo];
    
}

@end

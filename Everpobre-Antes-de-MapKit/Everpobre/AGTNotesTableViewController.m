//
//  AGTNotesTableViewController.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 15/04/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "AGTNotesTableViewController.h"
#import "AGTNotebook.h"
#include "AGTNote.h"

@interface AGTNotesTableViewController ()
@property (strong, nonatomic) AGTNotebook *model;
@end

@implementation AGTNotesTableViewController

-(id) initWithNotebook:(AGTNotebook *)notebook{
    
    
    // Creamos el fetchedResults
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGTNote entityName]];
    req.predicate = [NSPredicate predicateWithFormat:@"notebook == %@", notebook];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AGTNamedEntityAttributes.name
                                                          ascending:YES]];
    
    NSFetchedResultsController *fetched = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                              managedObjectContext:notebook.managedObjectContext
                                                                                sectionNameKeyPath:nil
                                                                                         cacheName:nil];
    if (self = [super initWithFetchedResultsController:fetched
                                                 style:UITableViewStylePlain]) {
        self.fetchedResultsController = fetched;
        self.model = notebook;
        self.title = notebook.name;
    }
    return self;
}

#pragma mark - data source
-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AGTNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    static NSString *cellId = @"NoteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellId];
    }
    cell.textLabel.text = note.name;
    
    return cell;
}







@end

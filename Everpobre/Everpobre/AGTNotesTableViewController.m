//
//  AGTNotesTableViewController.m
//  Everpobre
//
//  Created by Roberto Halgravez on 6/28/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTNotesTableViewController.h"
#import "AGTNotebook.h"
#import "AGTNote.h"

@interface AGTNotesTableViewController ()

@property (strong, nonatomic) AGTNotebook *model;

@end

@implementation AGTNotesTableViewController

-(instancetype)initWithNotebook:(AGTNotebook *)notebook {
    //Creamos el fetch results
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGTNote entityName]];
    req.predicate = [NSPredicate predicateWithFormat:@"notebook == %@", notebook];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:[AGTNamedEntityAttributes name] ascending:YES]];
    
    NSFetchedResultsController *fetched = [[NSFetchedResultsController alloc] initWithFetchRequest:req managedObjectContext:notebook.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    if (self = [super initWithFetchedResultsController:fetched style:UITableViewStylePlain]) {
        self.fetchedResultsController = fetched;
        self.model = notebook;
        self.title = notebook.name;
    }
    return self;
}

#pragma mark - Data Source
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AGTNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    static NSString *cellId = @"NoteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = note.name;
    
    return cell;
}

@end

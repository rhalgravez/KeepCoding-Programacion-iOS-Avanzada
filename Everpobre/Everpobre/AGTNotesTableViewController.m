//
//  AGTNotesTableViewController.m
//  Everpobre
//
//  Created by Roberto Halgravez on 6/9/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTNotesTableViewController.h"
#import "AGTNote.h"

@interface AGTNotesTableViewController ()

@property(nonatomic, strong) AGTNotebook *model;//Property to save the model

@end

@implementation AGTNotesTableViewController

-(instancetype)initWithNotebook:(AGTNotebook *)notebook {
    
    //1) Create fetch request
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[AGTNote entityName]];
    //2) Create predicate
    request.predicate = [NSPredicate predicateWithFormat:@"notebook == %@", notebook];
    //3) Create a sortDescriptor so we can put a FetchRequest inside of a FetchResult
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:[AGTNamedEntityAttributes name] ascending:YES]];
    //4) Create FetchResult
    NSFetchedResultsController *result =[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:notebook.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    if (self = [super initWithFetchedResultsController:result style:UITableViewStylePlain]) {
        self.fetchedResultsController = result;
        self.model = notebook;
        self.title = notebook.name;
    }
    
    return self;
    
}

@end

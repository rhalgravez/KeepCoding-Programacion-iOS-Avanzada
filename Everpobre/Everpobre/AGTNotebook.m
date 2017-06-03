#import "AGTNotebook.h"

@interface AGTNotebook ()

// Private interface goes here.
+(NSArray *)observableKeyNames;

@end

@implementation AGTNotebook

// Custom logic goes here.

+(instancetype)notebookWithName:(NSString *)name context:(NSManagedObjectContext *)context {
    
    AGTNotebook *notebook = [NSEntityDescription insertNewObjectForEntityForName:[AGTNotebook entityName] inManagedObjectContext:context];
    
    notebook.name = name;
    notebook.creationDate = [NSDate date];
    //modificationDate should change automatically, this need a review
    notebook.modificationDate = [NSDate date];
    
    return notebook;
    
}

+(NSArray *)observableKeyNames {
    return @[@"creationDate", @"name", @"notes"];
}

@end

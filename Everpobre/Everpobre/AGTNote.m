#import "AGTNote.h"

@interface AGTNote ()

// Private interface goes here.
+(NSArray *)observableKeyNames;

@end

@implementation AGTNote

// Custom logic goes here.

-(BOOL)hasLocation {
    return (nil == self.location);
}

+(NSArray *)observableKeyNames {
    return @[@"name", @"creationDate", @"text", @"notebook", @"photo"];
}

+(instancetype)noteWithName:(NSString *)name
                   notebook:(AGTNotebook *)notebook
                    context:(NSManagedObjectContext *)context {
    
    AGTNote *note = [NSEntityDescription insertNewObjectForEntityForName:[AGTNote entityName] inManagedObjectContext:context];
    
    
    note.name = name;
    note.notebook = notebook;
    note.creationDate = [NSDate date];
    //modificationDate should change automatically, this need a review
    note.modificationDate = [NSDate date];
    
    return note;
}

@end

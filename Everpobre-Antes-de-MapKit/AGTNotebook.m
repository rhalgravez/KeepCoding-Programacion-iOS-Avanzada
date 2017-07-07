#import "AGTNotebook.h"


@interface AGTNotebook ()

+(NSArray *)observableKeyNames;

@end


@implementation AGTNotebook
+(NSArray *)observableKeyNames{
    return @[@"creationDate", @"name", @"notes"];
}

+(instancetype) notebookWithName:(NSString *)name
                         context:(NSManagedObjectContext *) context{
    
    AGTNotebook *nb = [NSEntityDescription insertNewObjectForEntityForName:[AGTNotebook entityName]
                                                    inManagedObjectContext:context];

    nb.name = name;
    nb.creationDate = [NSDate date];
    nb.modificationDate = [NSDate date];
    return nb;
}















@end











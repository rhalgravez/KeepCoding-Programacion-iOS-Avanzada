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

#pragma mark - KVO

-(void)setupKVO {
    
    for (NSString *key in [AGTNotebook observableKeyNames]) {
        [self addObserver:self
               forKeyPath:key
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:NULL];
    }
    
}

-(void)tearDownKVO {
    for (NSString *key in [AGTNotebook observableKeyNames]) {
        [self removeObserver:self forKeyPath:key];
    }
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context {
    
    self.modificationDate = [NSDate date];
    
}
@end

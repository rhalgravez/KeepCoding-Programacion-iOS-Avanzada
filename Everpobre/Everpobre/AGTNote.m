#import "AGTNote.h"

@interface AGTNote ()

// Private interface goes here.
+(NSArray *)observableKeyNames;

@end

@implementation AGTNote

// Custom logic goes here.

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

#pragma mark - KVO

-(void)setupKVO {
    
    for (NSString *key in [AGTNote observableKeyNames]) {
        [self addObserver:self
               forKeyPath:key
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:NULL];
    }
    
}

-(void)tearDownKVO {
    for (NSString *key in [AGTNote observableKeyNames]) {
        [self removeObserver:self forKeyPath:key];
    }
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context {
    
    self.modificationDate = [NSDate date];
    
}

#pragma mark - LifeCycle

-(void)awakeFromInsert {
    [super awakeFromInsert];
    [self setupKVO];
}

-(void)awakeFromFetch {
    [super awakeFromFetch];
    [self setupKVO];
}

-(void)willTurnIntoFault {
    [super willTurnIntoFault];
    [self tearDownKVO];
}


@end

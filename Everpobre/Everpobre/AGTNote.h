#import "_AGTNote.h"

@interface AGTNote : _AGTNote
// Custom logic goes here.
@property(nonatomic, readonly) BOOL hasLocation;

+(instancetype)noteWithName:(NSString *)name
                   notebook:(AGTNotebook *)notebook
                    context:(NSManagedObjectContext *)context;

@end

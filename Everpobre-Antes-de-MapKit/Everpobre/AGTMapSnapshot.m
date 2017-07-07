#import "AGTMapSnapshot.h"
#import "AGTLocation.h"

@interface AGTMapSnapshot ()

// Private interface goes here.

@end

@implementation AGTMapSnapshot

// Custom logic goes here.
#pragma mark - Properties
-(UIImage *)image {
    return [UIImage imageWithData:self.snapshotData];
}

-(void)setImage:(UIImage *)image {
    self.snapshotData = UIImageJPEGRepresentation(image, 0.9);
}

#pragma mark - Class Names
+(instancetype)mapSnapshotForLocation:(AGTLocation *)location {
    
    AGTMapSnapshot *mapSnapshot = [AGTMapSnapshot insertInManagedObjectContext:location.managedObjectContext];
    mapSnapshot.location = location;
    
    return mapSnapshot;
    
}


@end

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

-(void)awakeFromInsert {
    [super awakeFromInsert];
    
    [self startObserving];
}

-(void)awakeFromFetch {
    [super awakeFromFetch];
     
    [self startObserving];
}

-(void)willTurnIntoFault {
    [super willTurnIntoFault];
    
    [self stopObserving];
}

#pragma mark - KVO
-(void)startObserving {
    [self addObserver:self
           forKeyPath:@"location"
              options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)stopObserving {
    [self removeObserver:self forKeyPath:@"location"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context {
    
    //Recalculamos el mapSnapShot
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(self.location.latitudeValue, self.location.longitudeValue);
    
    MKMapSnapshotOptions *options = [MKMapSnapshotOptions new];
    options.region = MKCoordinateRegionMakeWithDistance(center, 3, 3);
    options.mapType = MKMapTypeHybrid;
    options.size = CGSizeMake(150, 150);
    
    MKMapSnapshotter *shotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    
    [shotter startWithCompletionHandler:^(MKMapSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (!error) {
            //Sin error
            self.image = snapshot.image;
        } else {
            //Uso este setPrimitiveLocation porque self.location = nil
            //crearía un  bucle infinito y con el método de abajo accedo
            //directaente a la variable de insatncia y no a la property
            [self setPrimitiveLocation:nil];
            [self.managedObjectContext deleteObject:self];
        }
    }];
}

@end

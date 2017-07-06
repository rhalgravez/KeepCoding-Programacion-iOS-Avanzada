#import "AGTLocation.h"
#import "AGTNote.h"

@import AddressBookUI;

@interface AGTLocation ()

// Private interface goes here.

@end

@implementation AGTLocation

// Custom logic goes here.
+(instancetype)locationWithCLLocation:(CLLocation*)location forNote:(AGTNote*)note {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[AGTLocation entityName]];
    NSPredicate *latitude = [NSPredicate predicateWithFormat:@"latitude == %f", location.coordinate.latitude];
    NSPredicate *longitude = [NSPredicate predicateWithFormat:@"longitude == %f", location.coordinate.longitude];
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[latitude, longitude]];
    
    NSError * error = nil;
    NSArray *results = [note.managedObjectContext executeFetchRequest:request error:&error];
    
    NSAssert(results, @"Error al buscar!");
    
    //Aprovechamos que ya existe esa location
    if ([results count]) {
        AGTLocation *found = [results lastObject];
        [found addNotesObject:note];
        return found;
    } else {
        AGTLocation *newLocation = [self insertInManagedObjectContext:note.managedObjectContext];
        newLocation.latitudeValue = location.coordinate.latitude;
        newLocation.longitudeValue = location.coordinate.longitude;
        [newLocation addNotesObject:note];
        
        //Dirección
        CLGeocoder *coder = [CLGeocoder new];
        [coder reverseGeocodeLocation:location
                    completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                        if (error) {
                            NSLog(@"Error with obtaining address!\n%@", error);
                        } else {
                            newLocation.address = [placemarks.lastObject.addressDictionary objectForKey:@"FormattedAddressLines"];
                        }
                    }];
        
        return newLocation;
    }
}

@end

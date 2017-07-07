#import "AGTLocation.h"
#import "AGTNote.h"
#import "AGTMapSnapshot.h"

#import <CoreLocation/CoreLocation.h>

@import AddressBookUI;

@interface AGTLocation ()

// Private interface goes here.

@end


@implementation AGTLocation


+(instancetype) locationWithCLLocation:(CLLocation*)location forNote:(AGTNote *) note{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGTLocation entityName]];
    NSPredicate *latitude = [NSPredicate predicateWithFormat:@"abs(latitude) - abs(%lf) < 0.001",
                             location.coordinate.latitude];
    NSPredicate *longitude = [NSPredicate predicateWithFormat:@"abs(longitude) - abs(%lf) < 0.001",
                              location.coordinate.longitude];
    req.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[latitude, longitude]];
    
    NSError *error;
    NSArray *results = [note.managedObjectContext executeFetchRequest:req
                                                                error:&error];
    
    NSAssert(results, @"¡Error al buscar una AGTLocation!");
    
    if ([results count]) {
        
        // Aprovechamos lo encontrado
        AGTLocation *found = [results lastObject];
        [found addNotesObject:note];
        return found;
        
    }else{
        // Creamos uno de cero
        AGTLocation *loc = [self insertInManagedObjectContext:note.managedObjectContext];
        loc.latitudeValue = location.coordinate.latitude;
        loc.longitudeValue = location.coordinate.longitude;
        [loc addNotesObject:note];
        
        //Creamos la dirección
        CLGeocoder *coder = [[CLGeocoder alloc]init];
        [coder reverseGeocodeLocation:location
                    completionHandler:^(NSArray *placemarks, NSError *error) {
                        
                        if (error) {
                            NSLog(@"Error while obtaining address!\n%@", error);
                        }else{
                            loc.address = ABCreateStringWithAddressDictionary([[placemarks lastObject] addressDictionary], YES);
                            NSLog(@"Address is %@", loc.address);
                        }
                    }];
        
        //Crear un mapSnapshot
        loc.mapSnapshot = [AGTMapSnapshot mapSnapshotForLocation:loc];
        
        return loc;

    }
    
    
    
}

#pragma mark - MKAnnotation
-(NSString *)titile {
    return @"I wrote a note here!";
}

-(NSString *)subtitle {
    //Cómo la dirección viene con saltos de línea eso podría dar problemas al subtitle
    //así que eliminamos los saltos de línea
    NSArray *lines = [self.address componentsSeparatedByString:@"\n"];
    NSMutableString *concat = [@"" mutableCopy];
    for (NSString *line in lines) {
        [concat appendFormat:@"%@", line];
    }
    
    return concat;
}

-(CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(self.latitudeValue, self.longitudeValue);
}


@end

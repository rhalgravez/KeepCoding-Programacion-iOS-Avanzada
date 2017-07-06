#import "AGTNote.h"
#import "AGTLocation.h"
@import CoreLocation;

@interface AGTNote () <CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;

// Private interface goes here.
+(NSArray *)observableKeyNames;

@end

@implementation AGTNote

// Custom logic goes here.

@synthesize locationManager = _locationManager;

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

#pragma mark - Init
-(void)awakeFromInsert {
    [super awakeFromInsert];
    
    //Averiguar si tiene sentido o no crear una localización
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (((status == kCLAuthorizationStatusAuthorizedAlways) || (status == kCLAuthorizationStatusNotDetermined)) && [CLLocationManager locationServicesEnabled]) {
        //tenemos localización!!!
        
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    //Paramos el locationManager para ahorrar batería
    [self.locationManager startUpdatingLocation];
    self.locationManager = nil;
    
    //Pillamos la última location
    CLLocation *LastLocation = [locations lastObject];
    
    //Creamos nuestra AGTLocation
    self.location = [AGTLocation locationWithCLLocation:LastLocation forNote:self];
}

@end

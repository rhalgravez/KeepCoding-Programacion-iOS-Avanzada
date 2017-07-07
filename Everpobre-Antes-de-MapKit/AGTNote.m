#import "AGTNote.h"
#import "AGTLocation.h"

@import CoreLocation;

@interface AGTNote ()<CLLocationManagerDelegate>

+(NSArray *)observableKeyNames;
@property (nonatomic,strong) CLLocationManager *locationManager;

@end


@implementation AGTNote
@synthesize locationManager=_locationManager;

-(BOOL)hasLocation{
    return (nil != self.location);
}

+(NSArray *) observableKeyNames{
    return @[@"name", @"creationDate", @"notebook", @"photo", @"location"];
    
}
+(instancetype) noteWithName:(NSString *) name
                    notebook:(AGTNotebook *) notebook
                     context:(NSManagedObjectContext *) context{
    
    AGTNote *note = [NSEntityDescription insertNewObjectForEntityForName:[AGTNote entityName]
                                                  inManagedObjectContext:context];
    
    note.creationDate = [NSDate date];
    note.notebook = notebook;
    note.modificationDate = [NSDate date];
    note.name = name;
    return note;
}


#pragma mark - Init
-(void) awakeFromInsert{
    [super awakeFromInsert];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if ( ((status == kCLAuthorizationStatusAuthorized) || (status == kCLAuthorizationStatusNotDetermined))
        && [CLLocationManager locationServicesEnabled]) {
        
        // Tenemos acceso a localización
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
        
        // No me interesan datos pasado mucho tiempo, asi que si no
        // recibimos posición en menos de 5 segundos, paramos al
        // locationManager
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self zapLocationManager];
        });
    }
    
}

#pragma mark - CLLocationManagerDelegate
-(void) locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    
    // paramos el location manager, que consume mucha bateria
    [self zapLocationManager];
    
    
    
    if (self.location == nil) {
        // Pillamos la última
        CLLocation *loc = [locations lastObject];
        
        // Creamos una AGTLocation
        self.location = [AGTLocation locationWithCLLocation:loc
                                                    forNote:self];
    }else{
        // Hay un bug desde iOS 4 que hace que a veces un location mana
        // siga mandando mensajes después de habersele dicho que pare.
        // No está claro que esté del todo resuelto, así que nos precavemos
        // con este if.
        NSLog(@"No deberíamos llegar aquí jamás");
    }
    
}



#pragma mark - Utils
-(void)zapLocationManager{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}















@end

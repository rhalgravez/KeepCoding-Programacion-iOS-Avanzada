#import "_AGTLocation.h"

@import CoreLocation;

@class AGTNote;

@interface AGTLocation : _AGTLocation <MKAnnotation> {}
// Custom logic goes here.

+(instancetype) locationWithCLLocation:(CLLocation*)location forNote:(AGTNote *) note;


@end

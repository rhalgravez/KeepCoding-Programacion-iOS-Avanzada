#import "_AGTLocation.h"

@class AGTNote;

@import CoreLocation;

@interface AGTLocation : _AGTLocation
// Custom logic goes here.
+(instancetype)locationWithCLLocation:(CLLocation*)location forNote:(AGTNote*)note;

@end

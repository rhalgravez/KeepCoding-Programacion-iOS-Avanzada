#import "_AGTMapSnapshot.h"

@interface AGTMapSnapshot : _AGTMapSnapshot
// Custom logic goes here.

@property (nonatomic, strong) UIImage *image;

+(instancetype)mapSnapshotForLocation:(AGTLocation *)location;

@end

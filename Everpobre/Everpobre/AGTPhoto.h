#import "_AGTPhoto.h"
#import <UIKit/UIKit.h>

@interface AGTPhoto : _AGTPhoto
// Custom logic goes here.

+(instancetype)photoWithImage:(UIImage *)image context:(NSManagedObjectContext *)context;

@end

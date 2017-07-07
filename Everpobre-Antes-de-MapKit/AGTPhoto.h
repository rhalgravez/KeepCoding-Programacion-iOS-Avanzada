#import "_AGTPhoto.h"

@interface AGTPhoto : _AGTPhoto {}
// Custom logic goes here.



@property(nonatomic, strong) UIImage *image;


+(instancetype) photoWithImage:(UIImage *) image
                       context:(NSManagedObjectContext *) context;

@end

#import "AGTPhoto.h"

@interface AGTPhoto ()

// Private interface goes here.

@end

@implementation AGTPhoto

// Custom logic goes here.

+(instancetype)photoWithImage:(UIImage *)image context:(NSManagedObjectContext *)context {
    
    AGTPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:[AGTPhoto entityName] inManagedObjectContext:context];
    
    photo.imageData = UIImagePNGRepresentation(image);
    
    return photo;
}

@end

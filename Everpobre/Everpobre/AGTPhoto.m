#import "AGTPhoto.h"

@interface AGTPhoto ()

// Private interface goes here.

@end

@implementation AGTPhoto

// Custom logic goes here.

#pragma mark - Properties

-(void)setImage:(UIImage *)image {
    
    self.imageData = UIImagePNGRepresentation(image);
}

-(UIImage *)image {
    
    return [UIImage imageWithData:self.imageData];
}

#pragma mark - Class Methods

+(instancetype)photoWithImage:(UIImage *)image context:(NSManagedObjectContext *)context {
    
    AGTPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:[AGTPhoto entityName] inManagedObjectContext:context];
    
    photo.imageData = UIImagePNGRepresentation(image);
    
    return photo;
}

@end

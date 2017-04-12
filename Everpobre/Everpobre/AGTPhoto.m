#import "AGTPhoto.h"

@interface AGTPhoto ()

// Private interface goes here.

@end

@implementation AGTPhoto

// Custom logic goes here.

@synthesize image = _image;

#pragma mark - Properties

-(void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageData = UIImagePNGRepresentation(image);
}

-(UIImage *)image {
    if (!_image) {
        _image = [UIImage imageWithData:self.imageData];
    }
    return _image;
}

#pragma mark - Class Methods

+(instancetype)photoWithImage:(UIImage *)image context:(NSManagedObjectContext *)context {
    
    AGTPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:[AGTPhoto entityName] inManagedObjectContext:context];
    
    photo.imageData = UIImagePNGRepresentation(image);
    
    return photo;
}

@end

#import "AGTPhoto.h"


@interface AGTPhoto ()

// Private interface goes here.

@end


@implementation AGTPhoto



#pragma mark - Properties

-(void) setImage:(UIImage *)image{
    
    // sincronizar con imageData
    self.imageData = UIImagePNGRepresentation(image);
    
}

-(UIImage *) image{
    
    
    return [UIImage imageWithData:self.imageData];
    
}


#pragma mark - Class Methods
+(instancetype) photoWithImage:(UIImage *) image
                       context:(NSManagedObjectContext *) context{
    
    AGTPhoto *p = [NSEntityDescription insertNewObjectForEntityForName:[AGTPhoto entityName]
                                                inManagedObjectContext:context];
    
    p.imageData = UIImageJPEGRepresentation(image, 0.9);
    
    
    return p;
    
}



































@end

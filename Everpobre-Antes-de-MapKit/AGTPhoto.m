#import "AGTPhoto.h"


@interface AGTPhoto ()

// Private interface goes here.

@end


@implementation AGTPhoto



#pragma mark - Properties

-(void) setImage:(UIImage *)image{
    
    // sincronizar con imageData
    //Cambio la función de representation para así posiblemente reudiciría los poicos de memoria
    //pero al hacer una prueba en instruments lo spicos de memoría siguen siendo enormes
    //de entre 148MB quizás hasta más de 200
    self.imageData = UIImageJPEGRepresentation(image, 0.9);
    
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

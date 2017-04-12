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
    
    //Notification for memory warning
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:photo selector:@selector(notifyThatDidReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
    
    return photo;
}

#pragma mark - Notifications

//UIApplicationDidReceiveMemoryWarningNotification
-(void)notifyThatDidReceiveMemoryWarning:(NSNotification *)notification {
    
    _image = nil;
    
}

#pragma mark - Lifecycle
-(void)dealloc {
    //dealloc the notification
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification removeObserver:self];
}


@end

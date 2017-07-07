#import "AGTMapSnapshot.h"

@interface AGTMapSnapshot ()

// Private interface goes here.

@end

@implementation AGTMapSnapshot

// Custom logic goes here.
#pragma mark - Properties
-(UIImage *)image {
    return [UIImage imageWithData:self.snapshotData];
}

-(void)setImage:(UIImage *)image {
    self.snapshotData = UIImageJPEGRepresentation(image, 0.9);
}

@end

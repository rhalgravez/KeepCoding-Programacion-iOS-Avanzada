//
//  AGTNoteCellView.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 16/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "AGTNoteCellView.h"
#import "AGTNote.h"
#import "AGTPhoto.h"

@interface AGTNoteCellView ()
@property (strong, nonatomic) AGTNote* note;
@end
@implementation AGTNoteCellView

+(NSArray*) keys{
    return @[@"photo.image", @"name", @"modificationDate", @"location", @"location.latitude", @"location.longitude", @"location.address"];
}
-(void) observeNote:(AGTNote *) note{
    
    self.note = note;
    
    for (NSString *key in [AGTNoteCellView keys]) {
        [self.note addObserver:self
                    forKeyPath:key
                       options:NSKeyValueObservingOptionNew
                       context:NULL];
    }
    
    [self syncWithNote];
    
}


-(void) prepareForReuse{
    
    for (NSString *key in [AGTNoteCellView keys]) {
        [self.note removeObserver:self forKeyPath:key];

    }
    self.note = nil;
    [self syncWithNote];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    
    [self syncWithNote];
    

    
}

-(void) syncWithNote{
    self.titleView.text = self.note.name;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    self.modificationDateView.text = [fmt stringFromDate:self.note.modificationDate];
    
    UIImage *img;
    if (self.note.photo.image == nil) {
        img = [UIImage imageNamed:@"noImage.png"];
    }else{
        img = self.note.photo.image;
    }
    self.photoView.image = img;
    if (self.note.hasLocation) {
        self.locationView.image = [UIImage imageNamed:@"placemark.png"];
    }else{
        self.locationView.image = nil;
    }

}




@end

//
//  AGTNoteCellView.m
//  Everpobre
//
//  Created by Roberto Halgravez on 6/22/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTNoteCellView.h"
#import "AGTNote.h"
#import "AGTPhoto.h"

@interface AGTNoteCellView ()

@property(strong, nonatomic) AGTNote *note;

@end

@implementation AGTNoteCellView
+(NSArray *) keys {
    return @[@"title", @"modificationDate", @"photo.image", @"location", @"location.latitud", @"location.longitude", @"location.address"];
}


-(void)observeNote:(AGTNote *) note {
    //Guardarla en la propiedad
    self.note = note;
    
    //Observar ciertas propiedades
    for (NSString *key in [AGTNoteCellView keys]) {
        [self.note addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:NULL];
    }
    [self syncWithNote];
}

-(void) syncWithNote {
    self.titleView.text = self.note.name;
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    self.modificationDAteView.text = [fmt stringFromDate:self.note.modificationDate];
    
    UIImage *img;
    if (!self.note.photo.image) {
        img = [UIImage imageNamed:@"noImage.pnh"];
    } else {
        img = self.note.photo.image;
    }
    self.photoView.image = img;
    
    if (self.note.hasLocation) {
        self.locationView.image = [UIImage imageNamed:@"placemark"];
    } else {
        self.locationView.image = nil;
    }
}

-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    [self syncWithNote];
    
}

-(void)prepareForReuse {
    self.note = nil;
    [self syncWithNote];
}
@end

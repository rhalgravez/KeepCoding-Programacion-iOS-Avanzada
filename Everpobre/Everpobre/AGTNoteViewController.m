//
//  AGTNoteViewController.m
//  Everpobre
//
//  Created by Roberto Halgravez on 6/29/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTNoteViewController.h"
#include "AGTNote.h"
#include "AGTPhoto.h"

@interface AGTNoteViewController ()

@property(nonatomic, strong) AGTNote *model;

@end

@implementation AGTNoteViewController

#pragma mark - Init
-(instancetype)initWithModel:(AGTNote *)model {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
    }
    return self;
}

#pragma mrk - View Lifecycle
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //modelo a la vista
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = NSDateFormatterLongStyle;
    self.modificationDateView.text = [formatter stringFromDate:self.model.modificationDate];
    self.nameView.text = self.model.name;
    self.textView.text = self.model.text;
    
    UIImage *img = self.model.photo.image;
    if (!img) {
        img = [UIImage imageNamed:@"noImage"];
    }
    self.photoView.image = img;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //vista al modelo
    self.model.text = self.textView.text;
    self.model.photo.image = self.photoView.image;
}

@end

//

//  AGTNoteTableViewController.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 19/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "AGTNoteTableViewController.h"
#import "AGTNote.h"
#import "AGTPhoto.h"




@interface AGTNoteTableViewController ()
@property (strong, nonatomic) IBOutlet UITableViewCell *modificationDateCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *photoAndMapCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *textCell;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) AGTNote *model;

@end

@implementation AGTNoteTableViewController



#pragma mark - init
-(id)initWithModel:(id)model{
    return [self initWithModel:model
                         style:UITableViewStylePlain];
}

-(id) initWithModel:(AGTNote*) model
              style:(UITableViewStyle) style{
    
    if (self = [super initWithStyle:style]) {
        _model = model;
    }
    
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterLongStyle;
    
    self.modificationDateLabel.text = [fmt stringFromDate:self.model.modificationDate];
    self.photoView.image = self.model.photo.image;
    self.nameLabel.text = self.model.name;
    self.textView.text = self.model.text;
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.model.text = self.textView.text;
    self.model.photo.image = self.photoView.image;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView
       cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            return self.modificationDateCell;
            break;
            
        case 1:
            return self.nameCell;
            break;
            
        case 2:
            return self.photoAndMapCell;
            break;
            
        case 3:
            return self.modificationDateCell;
            break;
            
        default:
            NSAssert(NO, @"Unknown cell type!");
            return nil;
            break;
    }
}

@end


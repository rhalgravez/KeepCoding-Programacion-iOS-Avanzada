//
//  AGTNotesViewController.m
//  Everpobre
//
//  Created by Roberto Halgravez on 6/28/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTNotesViewController.h"
#import "AGTNote.h"
#import "AGTNoteCellView.h"
#import "AGTPhoto.h"

static NSString *cellID = @"NoteCellId";

@interface AGTNotesViewController ()

@end

@implementation AGTNotesViewController

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self registerNib];
}

#pragma mark - Xib registration
-(void)registerNib {
    UINib *nib = [UINib nibWithNibName:@"AGTNoteCollectionViewCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:cellID];
}

#pragma mark - Data Source
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //Obtener el objeto
    AGTNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Obtener una celda
    AGTNoteCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    //Configurar la celda
    cell.titleView.text = note.name;
    cell.photoView.image = note.photo.image;
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    cell.modificationDAteView.text = [fmt stringFromDate:note.modificationDate];
    
    return cell;
}
@end

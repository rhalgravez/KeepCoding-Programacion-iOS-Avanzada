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
#import "AGTNoteViewController.h"

static NSString *cellID = @"NoteCellId";

@interface AGTNotesViewController ()

@end

@implementation AGTNotesViewController

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self registerNib];
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    self.detailViewControllerClassName = NSStringFromClass([AGTNoteViewController class]);
    
    self.title = @"Notas";
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNote:)];
    self.navigationItem.rightBarButtonItem = add;
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
    [cell observeNote:note];
    
    return cell;
}

#pragma mark - Utils
-(void)addNewNote:(id)sender {
    AGTNoteViewController *newNoteVC = [[AGTNoteViewController alloc] initForNewNoteInNotebook:self.notebook];
    [self.navigationController pushViewController:newNoteVC animated:YES];
}

@end

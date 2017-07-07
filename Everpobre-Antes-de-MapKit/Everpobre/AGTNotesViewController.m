//
//  AGTNotesViewController.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 17/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "AGTNotesViewController.h"
#import "AGTNote.h"
#import "AGTNoteCellView.h"
#import "AGTPhoto.h"
#import "AGTNoteViewController.h"

static NSString *cellId = @"NoteCellId";

@interface AGTNotesViewController ()

@end

@implementation AGTNotesViewController

#pragma mark -  View Lifecicle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerCell];
    
    self.title = @"Notas";
    self.detailViewControllerClassName = NSStringFromClass([AGTNoteViewController class]);
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addNote:)];
    self.navigationItem.rightBarButtonItem = add;
    
}

#pragma mark - cell registration
-(void) registerCell{
    
    UINib *nib = [UINib nibWithNibName:@"AGTNoteCollectionViewCell"
                                bundle:nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:cellId];
}

#pragma mark - Data Source
-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener el objeto
    AGTNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Obtener la celda
    AGTNoteCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                      forIndexPath:indexPath];
    // Configurarla
    [cell observeNote:note];
    
    
    // Devolcerla
    return cell;
}

#pragma mark - Utils
-(void) addNote:(id) sender{
    
    AGTNoteViewController *newNoteVC = [[AGTNoteViewController alloc] initForNewNoteInNotebook:self.notebook];
    [self.navigationController pushViewController:newNoteVC
                                         animated:YES];
    
}

#pragma mark -  Delegate
//-(void) collectionView:(UICollectionView *)collectionView
//didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    // Obtener el objeto
//    AGTNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    
//    // Crear el controlador
//    AGTNoteViewController *noteVC = [[AGTNoteViewController alloc] initWithModel:note];
//    
//    // Hacer un push
//    [self.navigationController pushViewController:noteVC
//                                         animated:YES];
//    
//}































@end

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
#import "AGTNotebook.h"

@interface AGTNoteViewController () <UITextFieldDelegate>

@property(nonatomic, strong) AGTNote *model;
@property(nonatomic) BOOL new;
@property(nonatomic) BOOL deleteCurrentNote;

@end

@implementation AGTNoteViewController

#pragma mark - AGTDetailViewController Delegate
-(id)initWithModel:(id)model {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
    }
    return self;
}

#pragma mark - Init
-(instancetype)initForNewNoteInNotebook:(AGTNotebook*)notebook {
    AGTNote *newNote = [AGTNote noteWithName:@"" notebook:notebook context:notebook.managedObjectContext];
    
    _new = YES;
    return [self initWithModel:newNote];
}

#pragma mark - View Lifecycle
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
    
    [self startObservingKeyboard];
    
    [self setupInputAccessoryView];
    
    if(self.new) {
        //Mostramos botón de cancelar
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
        self.navigationItem.rightBarButtonItem = cancel;
    }
    
    self.nameView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.deleteCurrentNote) {
        [self.model.managedObjectContext deleteObject:self.model];
    } else {
        //vista al modelo
        self.model.text = self.textView.text;
        self.model.photo.image = self.photoView.image;
        self.model.name = self.nameView.text;
    }
    
    [self stopObservingKeyboard];
}

#pragma mark - Keyboard
-(void)startObservingKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(notifyThatKeyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(notifyThatKeyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)stopObservingKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

-(void)notifyThatKeyboardWillAppear:(NSNotification *)notification {
    //averiguar quien es el fisrtRespodner para ver si idsparamos la animación
    if ([self.textView isFirstResponder]) {
        //extrar el userInfo
        NSDictionary *dict = notification.userInfo;
        
        //extraer la duración de la animación
        double duration = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        //Cambiar las propiedades de la caja de texto
        [UIView animateWithDuration:duration delay:0 options:0 animations:^{
            //mover el frame del textView a donde se encuentra el modificationDateView y cambiar su tamaño para que cubra la pantalla y no se vea la imageView ni el mapViw en el fondo
            self.textView.frame = CGRectMake(self.modificationDateView.frame.origin.x, self.modificationDateView.frame.origin.y, self.view.frame.size.width, self.textView.frame.size.width);
        } completion:nil];
        
        //Hacer le textView translucido (para que se vea guay!!!)
        [UIView animateWithDuration:duration animations:^{
            self.textView.alpha = 0.8;
        }];
    }
}

-(void)notifyThatKeyboardWillDisappear:(NSNotification *)notification {
    if ([self.textView isFirstResponder]) {
        //extrar el userInfo
        NSDictionary *dict = notification.userInfo;
        
        //extraer la duración de la animación
        double duration = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        //Cambiar las propiedades de la caja de texto
        [UIView animateWithDuration:duration delay:0 options:0 animations:^{
            //mover el frame del textView a donde se encontraba
            self.textView.frame = CGRectMake(0, 323, self.view.frame.size.width, self.textView.frame.size.width);
        } completion:nil];
        
        //Regresaar el textView a su opacidad normal
        [UIView animateWithDuration:duration animations:^{
            self.textView.alpha = 1;
        }];
    }
}

-(void)setupInputAccessoryView {
    //creamos una barra
    UIToolbar *tootlbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 44)];
    
    //añadimos botones
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
    
    //Botón para mover el botón de done a la derecha
    UIBarButtonItem *separador = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *smile = [[UIBarButtonItem alloc] initWithTitle:@":-)" style:UIBarButtonItemStylePlain target:self action:@selector(insertTitle:)];
    
    [tootlbar setItems:@[smile, separador,done]];
    
    //y la asignamos como accesoryInputView
    self.textView.inputAccessoryView = tootlbar;
}

-(void)dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
}

-(void)insertTitle:(UIBarButtonItem*)sender {
    [self.textView insertText:sender.title];
}

#pragma mark - Utils
-(void)cancel:(id)sender {
    self.deleteCurrentNote = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    //podríamos validar el texto
    [textField resignFirstResponder];
    return YES;
}

@end

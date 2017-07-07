//
//  AGTPhotoViewController.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 22/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "AGTPhotoViewController.h"
#import "AGTPhoto.h"
@import CoreImage;

@interface AGTPhotoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) AGTPhoto *model;
@end

@implementation AGTPhotoViewController

-(id)initWithModel:(id)model{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
    }
    return self;
}

#pragma mark - View Lifecicle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.photoView.image = self.model.image;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.model.image = self.photoView.image;
}

- (IBAction)takePicture:(id)sender {
    
    // Crear uipicker
    UIImagePickerController *picker = [UIImagePickerController new];
    
    // configurar
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    picker.delegate = self;
    
    // mostrar
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         //
                     }];
    
    
}

- (IBAction)deletePhoto:(id)sender {
    
    
    // Estado inicial
    CGRect oldBounds = self.photoView.bounds;
    
    // Eliminarla de la vista
    [UIView animateWithDuration:0.6
                          delay:0
                        options:0
                     animations:^{
                         
                         self.photoView.bounds = CGRectZero;
                         self.photoView.alpha = 0;
                         self.photoView.transform = CGAffineTransformMakeRotation(M_2_PI);
                         
                     } completion:^(BOOL finished) {
                         self.photoView.image = nil;
                         self.photoView.alpha = 1;
                         self.photoView.bounds = oldBounds;
                         self.photoView.transform = CGAffineTransformIdentity;
                     }];
    
    
    
    
    
    // eliminarla del modelo
    self.model.image = nil;

    
    
}

- (IBAction)applyVintageEffect:(id)sender {
    
    // Crear un contexto
    CIContext *ctxt = [CIContext contextWithOptions:nil];
    
    // Crear una CIImage de entrada
    CIImage *input = [CIImage imageWithCGImage: self.model.image.CGImage];
    
    // Crear el filtro
    CIFilter *old = [CIFilter filterWithName:@"CIFalseColor"];
    [old setDefaults];
    [old setValue:input forKeyPath:kCIInputImageKey];
    
    // El vignette
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
    [vignette setDefaults];
    [vignette setValue:@12 forKeyPath:kCIInputIntensityKey];
    
    // encadenamos
    [vignette setValue:old.outputImage forKeyPath:kCIInputImageKey];
    
    // Obtener la imagen de salida
    CIImage *output = [vignette outputImage];
    
    
    // Aplicar el filtro
    [self.activityView startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGImageRef res = [ctxt createCGImage:output
                                    fromRect:[output extent]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityView stopAnimating];
            
            // Guardamos la imagen
            UIImage *img = [UIImage imageWithCGImage:res];
            self.photoView.image = img;
            
            // liberamos el CGImageRef
            CGImageRelease(res);
        });
    });
    
    
    
    
    
}

- (IBAction)zoomToFace:(id)sender {
    
    NSArray *features = [self featuresInImage:self.photoView.image];
    
    CIFeature *face = [features lastObject];
    CGRect faceBounds = [face bounds];
    
    CIImage *image = [CIImage imageWithCGImage:self.photoView.image.CGImage];
    
    CIImage *crop = [image imageByCroppingToRect:faceBounds];
    UIImage *newImage =[UIImage imageWithCIImage:crop];

    self.photoView.image = newImage;
}


#pragma mark -  Utils

-(NSArray *) featuresInImage:(UIImage *)image{
    
    CIContext *ctxt = [CIContext contextWithOptions:nil];
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:ctxt
                                              options:@{CIDetectorAccuracy:					CIDetectorAccuracyHigh}];
    
    CIImage *img = [CIImage imageWithCGImage:image.CGImage];
    
    NSArray *features = [detector featuresInImage:img];
    if (features) {
        return features;
    }else{
        return nil;
    }
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    self.model.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 
                             }];
    
    
}
@end

























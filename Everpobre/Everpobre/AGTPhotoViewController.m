//
//  AGTPhotoViewController.m
//  Everpobre
//
//  Created by Roberto Halgravez on 6/30/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTPhotoViewController.h"
#import "AGTPhoto.h"
@import CoreImage;

@interface AGTPhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) AGTPhoto *model;

@end

@implementation AGTPhotoViewController

#pragma mark - AGTDetailViewController
-(id)initWithModel:(id)model {
    
    NSAssert(model, @"Model can't be nil");
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
    }
    return self;
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.photoView.image = self.model.image;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.model.image = self.photoView.image;
}

#pragma mark - Actions

- (IBAction)takePhoto:(id)sender {
    //Crearlo
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    //configurar
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    //modifcar la transición del picker
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    //Asignar delegado
    picker.delegate = self;
    
    
    
    //mostarlo
    [self presentViewController:picker animated:YES completion:^{
        //no se nos ocurre nada por hacer aquí XD
    }];
}

- (IBAction)deletePhoto:(id)sender {
    
    //Estado incial
    CGRect oldBounds = self.photoView.bounds;
    
    //Eliminar la foto de la vista
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
    self.model.image = nil;
}

- (IBAction)applyVintageEffect:(id)sender {
    //Crear un contexto
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //Crear CIImage de entrada
    CIImage *image = [CIImage imageWithCGImage:self.model.image.CGImage];
    
    //Crear filtro(s)
    CIFilter *old = [CIFilter filterWithName:@"CIFalseColor"];
    [old setDefaults];
    [old setValue:image forKey:kCIInputImageKey];
    
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
    [vignette setDefaults];
    [vignette setValue:@12 forKey:kCIInputIntensityKey];
    
    //Encadenar los filtros
    [vignette setValue:old.outputImage forKey:kCIInputImageKey];

    //Obtener imagen de salida
    CIImage *output = vignette.outputImage;
    
    //Aplicar el filtro
    [self.activityView startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0
                                             ), ^{
        CGImageRef res = [context createCGImage:output fromRect:[output extent]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityView stopAnimating];
            
            //Guardamos la nueva imagen
            UIImage *img = [UIImage imageWithCGImage:res];
            self.photoView.image = img;
            
            //Liberar el CGImageRef
            CGImageRelease(res);
        });
    });
    
    
    
}

- (IBAction)zoomToFace:(id)sender {
    NSArray *features = [self featuresInImage:self.photoView.image];
    
    if (features) {
        //Obtenemos la última cara
        CIFeature *face = [features lastObject];
        //Obtenemos la posición de la cara
        CGRect faceBounds = [face bounds];
        
        //Crear una nueva imagen sólo con la cara
        CIImage *image = [CIImage imageWithCGImage:self.photoView.image.CGImage];
        CIImage * crop = [image imageByCroppingToRect:faceBounds];
        
        UIImage *newImage = [UIImage imageWithCIImage:crop];
        //Mostrar esa imagen
        self.photoView.image = newImage;
    }
}

#pragma mark - Utils

-(NSArray*)featuresInImage:(UIImage*)image {
    //Crer contexto
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //Crear el detector
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:context
                                              options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    
    //Necesitamos la CiImage para detectar las caras
    CIImage *img = [CIImage imageWithCGImage:image.CGImage];
    
    //Extraer las features (en este caso las caras)
    NSArray *features = [detector featuresInImage:img];
    if ([features count]) {
        return features;
    } else {
        return nil;
    }
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    self.model.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //Ahora sí tengo que quitar la vista del ImagePicker
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

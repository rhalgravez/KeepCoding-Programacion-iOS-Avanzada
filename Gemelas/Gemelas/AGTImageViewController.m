//
//  AGTImageViewController.m
//  Gemelas
//
//  Created by Roberto Manuel Halgravez Perea on 3/29/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTImageViewController.h"

@interface AGTImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoView;


@end

@implementation AGTImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions
- (IBAction)donwloadImage:(id)sender {
    
    //Create a queue
    dispatch_queue_t gemelas = dispatch_queue_create("charmander", 0);
    
    //Send to background thread
    dispatch_async(gemelas, ^{
        NSURL *url = [NSURL URLWithString:@"http://kingofwallpapers.com/charmander/charmander-013.jpg"];
        
         NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        //Execute in main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            
            self.photoView.image = image;
        });
    });
    
    
    
    
}


@end

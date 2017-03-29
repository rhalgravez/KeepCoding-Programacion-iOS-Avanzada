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
    [self imageFromInternetWithCompletitionHandler:^(UIImage *image) {
        self.photoView.image = image;
    }];
}

#pragma mark - Utils
-(void)imageFromInternetWithCompletitionHandler:(void (^)(UIImage *image))completitionHandler {
    //Download image in background thread
    //Now best practice, use dispatch_get_global_queue to reuse a queue already available in the system
    dispatch_queue_t download = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(download, ^{
        NSURL *url = [NSURL URLWithString:@"http://kingofwallpapers.com/charmander/charmander-013.jpg"];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Execute completitonHandler
            UIImage *image = [UIImage imageWithData:data];
            completitionHandler(image);
        });
    });
}

@end

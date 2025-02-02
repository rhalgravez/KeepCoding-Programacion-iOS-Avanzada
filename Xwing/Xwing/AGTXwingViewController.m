//
//  AGTXwingViewController.m
//  Xwing
//
//  Created by Roberto Manuel Halgravez Perea on 4/6/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTXwingViewController.h"

@interface AGTXwingViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *spaceView;
@property (weak, nonatomic) IBOutlet UIImageView *xwingView;

@end

@implementation AGTXwingViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userDidTap:)];
    [self.view addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(userDidSwipe:)];
    [self.view addGestureRecognizer:swipe];
}

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

#pragma mark - Action
-(void)userDidSwipe:(UISwipeGestureRecognizer *) swipe {
    if (swipe.state == UIGestureRecognizerStateRecognized) {
        static CGFloat angle = 0;
        [UIView animateWithDuration:3
                              delay:0
             usingSpringWithDamping:0.2
              initialSpringVelocity:0.8
                            options:0
                         animations:^{
                             angle = angle + M_PI_2;
                             self.xwingView.transform = CGAffineTransformMakeRotation(angle);
                         } completion:nil];
    }
}

-(void)userDidTap:(UITapGestureRecognizer *)tap {
    CGPoint newCenter = [tap locationInView:self.spaceView];
    
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState;
    
    [UIView animateWithDuration:1
                          delay:0
                        options:options animations:^{
                            self.xwingView.center = newCenter;
                        }
                     completion:^(BOOL finished) {
                         //For now we do nothing here
                     }];
    
   [ UIView animateWithDuration:0.5
                          delay:0
                        options:options
                     animations:^{
                         self.xwingView.transform = CGAffineTransformMakeRotation(M_2_PI);
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.5
                                               delay:0
                                             options:options
                                          animations:^{
                                              self.xwingView.transform = CGAffineTransformIdentity;
                                          } completion:nil];
                         
                     }];
}

@end

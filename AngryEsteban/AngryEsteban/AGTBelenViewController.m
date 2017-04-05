//
//  AGTBelenViewController.m
//  AngryEsteban
//
//  Created by Roberto Manuel Halgravez Perea on 4/4/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTBelenViewController.h"

@interface AGTBelenViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *belenView;

@property (strong, nonatomic) UIImageView *lastShot;
@end

@implementation AGTBelenViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Creat the gestures
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    
    //Add the gestures to the view
    [self.view addGestureRecognizer:tap];
    [self.view addGestureRecognizer:pan];
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

#pragma mark - Actions
-(void)didTap:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateRecognized) {
        UIImageView *crack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"crackedGlass"]];
        crack.center = [tap locationInView:self.belenView];
        [self.belenView addSubview:crack];
        
        //Maybe add a sound effect
    }
}

-(void)didPan:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint currentPosition = [pan locationInView:self.belenView];
        CGRect lastShotRect = self.lastShot.frame;
        
        if (!CGRectContainsPoint(lastShotRect, currentPosition)) {
            UIImageView *shot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bloodWound"]];
            shot.center = currentPosition;
            [self.belenView addSubview:shot];
            
            self.lastShot = shot;
        }
        
    }
}

-(void)didSwipe:(UISwipeGestureRecognizer *)swipe {
    
}

@end

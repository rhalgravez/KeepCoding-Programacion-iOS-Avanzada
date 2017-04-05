//
//  AGTBelenViewController.m
//  AngryEsteban
//
//  Created by Roberto Manuel Halgravez Perea on 4/4/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTBelenViewController.h"
#import "AGTSystemSounds.h"

@interface AGTBelenViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *belenView;

@property (strong, nonatomic) UIImageView *lastShot;

@property (strong, nonatomic) NSArray *showSprite;//Array to show the tape
@property (strong, nonatomic) NSArray *hideSprite;//Array to hide the tape
@property (strong, nonatomic) UIImageView *tapeView;

@end

@implementation AGTBelenViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Sprites
    self.showSprite = @[[UIImage imageNamed:@"tape1"], [UIImage imageNamed:@"tape2"], [UIImage imageNamed:@"tape3"], [UIImage imageNamed:@"tape4"]];
    self.hideSprite = @[[UIImage imageNamed:@"tape4"], [UIImage imageNamed:@"tape3"], [UIImage imageNamed:@"tape2"], [UIImage imageNamed:@"tape1"]];
    
    
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
        [self playPunch];
        
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
        
    } else if(pan.state == UIGestureRecognizerStateBegan) {
        //Start machin gun
        [[AGTSystemSounds sharedSystemSounds] startMachinGun];
        
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        //stop the machin gun
        [[AGTSystemSounds sharedSystemSounds] stopMachinGun];
    }
}

-(void)didSwipe:(UISwipeGestureRecognizer *)swipe {
    if (swipe.state == UIGestureRecognizerStateRecognized) {
        
        if (!self.tapeView) {
            //We need to put the tape
            
            [[AGTSystemSounds sharedSystemSounds] tape];
            
            self.tapeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tape4"]];
            self.tapeView.animationImages = self.showSprite;
            self.tapeView.animationRepeatCount = 1;
            self.tapeView.animationDuration = 0.2;
            
            self.tapeView.center = [swipe locationInView:self.belenView];
            [self.belenView addSubview:self.tapeView];
            
            [self.tapeView startAnimating];
        } else {
            //take off the tape
            
            [[AGTSystemSounds sharedSystemSounds] untape];
            
            self.tapeView.animationImages = self.hideSprite;
            self.tapeView.image = nil;
            [self.tapeView startAnimating];
            
            double delayInSeconds = 0.4;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //Remove the tape
                [self.tapeView removeFromSuperview];
                self.tapeView = nil;
            });
        }
        
    }
    
}

#pragma mark - Shake
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        for (UIView *view in self.belenView.subviews) {
            [view removeFromSuperview];
        }
        self.tapeView = nil;
        
        [[AGTSystemSounds sharedSystemSounds] binLaden]
        
    }
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Sound
-(void) playPunch {
    [[AGTSystemSounds sharedSystemSounds] punch];
}

@end

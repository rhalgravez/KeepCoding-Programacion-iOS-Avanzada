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

@end

@implementation AGTBelenViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Creat the gestures
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
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
    
}

-(void)didPan:(UIPanGestureRecognizer *)pan {
    
}

-(void)didSwipe:(UISwipeGestureRecognizer *)swipe {
    
}

@end

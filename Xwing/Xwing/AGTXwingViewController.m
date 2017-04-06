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
-(void)userDidTap:(UITapGestureRecognizer *)tap {
    CGPoint newCenter = [tap locationInView:self.spaceView];
    
    self.xwingView.center = newCenter;
}

@end

//
//  AGTImageViewController.m
//  Concurrencia II
//
//  Created by Roberto Manuel Halgravez Perea on 3/30/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTImageViewController.h"
#import "AGTImageDownloader.h"
#import "AGTImageFilterOperation.h"

@interface AGTImageViewController ()

@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation AGTImageViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
    }
    
    return self;
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
- (IBAction)downloadImage:(id)sender {
    //Setup the interface
    [self.activityView startAnimating];
    
    //Create operations
    AGTImageDownloader *downloader = [[AGTImageDownloader alloc] initWithImageViewController:self];
    AGTImageFilterOperation *filterOperation = [[AGTImageFilterOperation alloc] initWithImageViewController:self];
    
    //Create dependecy between the operations
    [filterOperation addDependency:downloader];
    
    //Send the operations to the queue
    [self.queue addOperation:downloader];
    [self.queue addOperation:filterOperation];
}


@end

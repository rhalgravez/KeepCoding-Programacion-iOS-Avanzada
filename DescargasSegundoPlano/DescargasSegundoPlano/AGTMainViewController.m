//
//  AGTMainViewController.m
//  DescargasSegundoPlano
//
//  Created by Roberto Manuel Halgravez Perea on 3/31/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import "AGTMainViewController.h"

@interface AGTMainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ativityView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressIndicatorView;

//URLs for the images
@property (strong, nonatomic) NSURL *bulbasaurURL;
@property (strong, nonatomic) NSURL *charmanderURL;

//URLSession for normal download and background
@property (strong, nonatomic) NSURLSession *downloadSession;
@property (strong, nonatomic) NSURLSession *backgroundDonwloadSession;

//Queue where all the delegates methods are executed
@property (strong, nonatomic) NSOperationQueue *delegateQueue;

@end

@implementation AGTMainViewController

#pragma mark - Lifecycle

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //Other way to fix the navigation bar overlapping the view
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    [self setupButtons];
    
    //Set the URL with its image
    self.bulbasaurURL = [NSURL URLWithString:@"http://vignette1.wikia.nocookie.net/pokemon/images/e/ea/001Bulbasaur_AG_anime.png"];
    self.charmanderURL = [NSURL URLWithString:@"http://cartoonbros.com/wp-content/uploads/2016/11/Charmander-3.png"];
    
    //Session
    [self setupDonwloadSession];
    [self setupBackgroundSession];
    
    self.delegateQueue = [[NSOperationQueue alloc] init];
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

#pragma mark - Utils

-(void)setupBackgroundSession {
    
}

-(void)setupDonwloadSession {
    //Create default configuration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //Create session
    self.downloadSession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:self.delegateQueue];
}

-(void)setupButtons {
    
    UIBarButtonItem *crashApp = [[UIBarButtonItem alloc] initWithTitle:@"Crash me!" style:UIBarButtonItemStylePlain target:self action:@selector(crashApp:)];
    
    UIBarButtonItem *foregroundDownload = [[UIBarButtonItem alloc] initWithTitle:@"Download" style:UIBarButtonItemStylePlain target:self action:@selector(download:)];
    
    UIBarButtonItem *backgroundDownload = [[UIBarButtonItem alloc] initWithTitle:@"Background Download" style:UIBarButtonItemStylePlain target:self action:@selector(downloadInBackground:)];
    
    [self.navigationItem setLeftBarButtonItem:crashApp];
    [self.navigationItem setRightBarButtonItems:@[foregroundDownload, backgroundDownload]];
}

//Get the progress in a float number
-(float)progressWithBytesSoFar:(int64_t)soFar totalExpectedBytes:(int64_t)totalBytes {
    return (soFar *1.0f)/(totalBytes*1.0);
}

#pragma mark - Actions
-(void) crashApp:(id)sender {
    //Crash by sending an unrecognized message
    [self performSelector:@selector(lucasGrijander) withObject:nil];
}

-(void)download:(id)sender {
    
}

-(void)downloadInBackground:(id)sender {
    
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    //We are in a background thread, so everything releated to UI needs to be done in the main thread!!
    NSLog(@"Session %@ is in progress!", session);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressIndicatorView.progress = [self progressWithBytesSoFar: totalBytesWritten totalExpectedBytes: totalBytesExpectedToWrite];
    });
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    //We are in a background thread, so everything releated to UI needs to be done in the main thread!!
    NSLog(@"Session %@ resumed!", session);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressIndicatorView.progress = [self progressWithBytesSoFar: fileOffset totalExpectedBytes: expectedTotalBytes];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    //We are in a background thread, so everything releated to UI needs to be done in the main thread!!
    NSLog(@"Session %@ finished downloading!", session);
    
    NSData *imgData = [NSData dataWithContentsOfURL:location];
    UIImage *img = [UIImage imageWithData:imgData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = img;
        [self.ativityView stopAnimating];
    });
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        //Smething faild
        NSLog(@"Error en session %@\n%@", session, error);
    } else {
        //Don't worry, be happy
        NSLog(@"Session %@ finished", session);
    }
}


@end

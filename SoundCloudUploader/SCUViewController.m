//
//  SCUViewController.m
//  SoundCloudUploader
//
//  Created by Freddie Peña on 09/11/13.
//  Copyright (c) 2013 fixem. All rights reserved.
//

#import "SCUViewController.h"
#import "SCUI.h"
#import "SCUTracksViewController.h"

@interface SCUViewController ()

@end

@implementation SCUViewController {
    SCUManager *sharedManager;
}


@synthesize loginButton, mySoundsButton, createSoundButton, uploadButton;

- (void)viewDidLoad {
    UIImage *background = [UIImage imageNamed: @"bg.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    
    [self.view insertSubview: imageView atIndex:0];
    
    [super viewDidLoad];
    
    sharedManager = [SCUManager sharedManager];
    loginButton.titleLabel.font = [UIFont fontWithName:@"YanoneKaffeesatz-Light" size:30];
    mySoundsButton.titleLabel.font = [UIFont fontWithName:@"YanoneKaffeesatz-Light" size:30];
    createSoundButton.titleLabel.font = [UIFont fontWithName:@"YanoneKaffeesatz-Light" size:30];
    uploadButton.titleLabel.font = [UIFont fontWithName:@"YanoneKaffeesatz-Light" size:30];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    // Enable upload button if we have an audio file when coming back
    // from the recording view
    if (sharedManager.hasRecording) {
        [uploadButton setEnabled:YES];
    }
    
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction) login:(id) sender {
    
    SCLoginViewControllerCompletionHandler handler = ^(NSError *error) {
        if (SC_CANCELED(error)) {
            NSLog(@"Cancelled");
        } else if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        } else {
            sharedManager.isSignedIn = YES;
            [loginButton setEnabled:NO];
            [mySoundsButton setEnabled:YES];
            [createSoundButton setEnabled:YES];
            NSLog(@"Done!");
        }
    };
    
    [SCSoundCloud requestAccessWithPreparedAuthorizationURLHandler:^(NSURL *preparedURL) {
        SCLoginViewController *loginViewController;
        
        loginViewController = [SCLoginViewController loginViewControllerWithPreparedURL:preparedURL completionHandler:handler];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }];
}


- (IBAction)upload:(id)sender {
    // Get the recorded audio
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"recording.m4a"];
    
    NSURL *trackURL = [NSURL fileURLWithPath:filePath];
    
    SCShareViewController *shareViewController;
    SCSharingViewControllerCompletionHandler handler;
    
    handler = ^(NSDictionary *trackInfo, NSError *error) {
        if (SC_CANCELED(error)) {
            NSLog(@"Cancelled");
        } else if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        } else {
            NSLog(@"Success! - %@", trackInfo);
        }
    };
    
    shareViewController = [SCShareViewController shareViewControllerWithFileURL:trackURL completionHandler:handler];
    [shareViewController setPrivate:YES];
    [self presentViewController:shareViewController animated:YES completion:nil];
}


@end

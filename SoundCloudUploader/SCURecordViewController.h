//
//  SCURecordViewController.h
//  SoundCloudUploader
//
//  Created by Freddie Peña on 11/11/13.
//  Copyright (c) 2013 fixem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SCURecordViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *recButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UILabel *recordLabel; // they all suck!!

- (IBAction)record:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)play:(id)sender;


@end

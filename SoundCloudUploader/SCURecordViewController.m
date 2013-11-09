//
//  SCURecordViewController.m
//  SoundCloudUploader
//
//  Created by Freddie Peña on 11/11/13.
//  Copyright (c) 2013 fixem. All rights reserved.
//

#import "SCURecordViewController.h"

@interface SCURecordViewController ()

@end

@implementation SCURecordViewController {
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    SCUManager *sharedManager;
}

@synthesize recButton, stopButton, playButton, recordLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // button appeareance
    recButton.layer.cornerRadius = recButton.bounds.size.width / 2.0;
    stopButton.layer.borderWidth=1.0f;
    stopButton.layer.borderColor=[[UIColor blackColor] CGColor];
    
    // SETTINGS VALUES
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 
    // sample rate
    CGFloat settingsSampleRate = [[defaults objectForKey:@"sample_rate"] floatValue];

    // audio format
    int format = kAudioFormatMPEG4AAC;
    
    // audio quality
    int settingsSoundQuality = [[defaults objectForKey:@"sound_quality"] integerValue];
    NSNumber *audioQuality = [NSNumber numberWithInt: AVAudioQualityMedium];
    switch (settingsSoundQuality) {
        case 1:
            audioQuality = [NSNumber numberWithInt: AVAudioQualityMin];
            break;
        case 2:
            audioQuality = [NSNumber numberWithInt: AVAudioQualityLow];
            break;
        case 3:
            audioQuality = [NSNumber numberWithInt: AVAudioQualityMedium];
            break;
        case 4:
            audioQuality = [NSNumber numberWithInt: AVAudioQualityHigh];
            break;
        case 5:
            audioQuality = [NSNumber numberWithInt: AVAudioQualityMax];
            break;
    }
    
    // Disable Stop and Play buttons
    stopButton.hidden = YES;
    playButton.hidden = YES;
    recordLabel.hidden = YES;
    
    // Audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], @"recording.m4a", nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
//    NSLog(@"Format: %d", format);
//    NSLog(@"Sample Rate: %.2f", settingsSampleRate);
//    NSLog(@"Audio Quality: %@", audioQuality);
    
    // Recorder settings
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    [recordSetting setValue:[NSNumber numberWithInt:format] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat: settingsSampleRate] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    [recordSetting setValue:audioQuality forKey:AVEncoderAudioQualityKey];
    
    // Initialize and prepare recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)record:(id)sender {

    // Stop the audio player before recording
    if (player.playing) {
        [player stop];
    }
    
    if (!recorder.recording) {
        NSLog(@"About to record...");
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [recorder record];
        recButton.backgroundColor = [UIColor greenColor];
        [recButton setTitle:@"PAUSE" forState:UIControlStateNormal];
        
    } else {
        NSLog(@"Recording paused...");
        
        // Pause recording
        [recorder pause];
        recButton.backgroundColor = [UIColor blackColor];
        [recButton setTitle:@"CONTINUE" forState:UIControlStateNormal];
    }
    
    stopButton.hidden = NO;
    playButton.hidden = YES;
    recordLabel.hidden = NO;
}

- (IBAction)stop:(id)sender {
    NSLog(@"stopped");
    
    [recorder stop];
    recButton.backgroundColor = [UIColor redColor];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

- (IBAction)play:(id)sender {
    NSLog(@"playing...");
    
    if (!recorder.recording){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        [player play];
    }
}


- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    [recButton setTitle:@"Record" forState:UIControlStateNormal];
    
    stopButton.hidden = YES;
    playButton.hidden = NO;
    recordLabel.hidden = YES;
    
    sharedManager = [SCUManager sharedManager];
    sharedManager.hasRecording = YES;
    
    NSLog(@"%@",recorder.url);
}


- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Sounds great!"
                                                    message: @"Playback ended"
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end

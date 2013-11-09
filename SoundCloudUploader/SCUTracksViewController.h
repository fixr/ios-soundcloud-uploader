//
//  SCUTracksViewController.h
//  SoundCloudUploader
//
//  Created by Freddie Peña on 09/11/13.
//  Copyright (c) 2013 fixem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SCUTracksViewController : UITableViewController <AVAudioPlayerDelegate>

@property (nonatomic, strong) NSArray *tracks;
@property (nonatomic, strong) AVAudioPlayer *player;

@end

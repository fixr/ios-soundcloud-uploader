//
//  SCUManager.h
//  SoundCloudUploader
//
//  Created by Freddie Peña on 26/11/13.
//  Copyright (c) 2013 fixem. All rights reserved.
//

#import <Foundation/Foundation.h>


// Behold the SCUM singleton :)

@interface SCUManager : NSObject {
    BOOL isSignedIn;
    BOOL hasRecording;
}

@property (nonatomic) BOOL isSignedIn;
@property (nonatomic) BOOL hasRecording;

+ (id)sharedManager;

@end

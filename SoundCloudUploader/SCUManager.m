//
//  SCUManager.m
//  SoundCloudUploader
//
//  Created by Freddie Peña on 26/11/13.
//  Copyright (c) 2013 fixem. All rights reserved.
//

#import "SCUManager.h"

@implementation SCUManager

@synthesize isSignedIn, hasRecording;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static SCUManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        isSignedIn = NO;
        hasRecording = NO;
    }
    return self;
}

- (void)dealloc {}

@end

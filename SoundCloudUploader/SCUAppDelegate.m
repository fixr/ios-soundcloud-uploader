//
//  SCUAppDelegate.m
//  SoundCloudUploader
//
//  Created by Freddie Peña on 09/11/13.
//  Copyright (c) 2013 fixem. All rights reserved.
//

#import "SCUAppDelegate.h"
#import "SCUI.h"

@implementation SCUAppDelegate

+ (void) initialize
{
    // ******************** //
    // API KEY: SET YOURS!  //
    // ******************** //
    //
    // Go to http://soundcloud.com/you/apps and
    // create one. Then set the ClientID and
    // Client Secret here.
    //
    [SCSoundCloud setClientID:@""
                       secret:@""
                  redirectURL:[NSURL URLWithString:@"scuploader://oauth"]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // SETTINGS INIT
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (! [defaults objectForKey:@"sample_rate"]) {
        [defaults setObject:@"44100" forKey:@"sample_rate"];
    }
    if (! [defaults objectForKey:@"sound_quality"]) {
        [defaults setObject:@"3" forKey:@"sound_quality"];
    }
    
    [defaults synchronize];
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

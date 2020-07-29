//
//  AppDelegate.m
//  The Amazing Hypno-Screen
//
//  Created by David Paige on 6/16/12.
//  Copyright 2012 Appbastard. All rights reserved.
//

#import "AppDelegate.h"
#import "iPhoneViewController.h"
#import "iPadViewController.h"
#import "iPhoneRetinaViewController.h"

@implementation AppDelegate

@synthesize window,phoneViewController,padViewController,phoneRetinaViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

//An if/else statement is used to poll for the proper device and set the proper view controller. The unused controllers are set to nil. The state of the idleTimerDisabled bool is also changed so that the hypno-screen will run until the user quits the app (or manually locks the device).   
    
    application.idleTimerDisabled = YES;
	
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		self.window.rootViewController = self.padViewController;
            phoneViewController = nil;
            phoneRetinaViewController = nil;
	}
    else {
			if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]
				&& [[UIScreen mainScreen] scale] == 2.0){
				self.window.rootViewController = self.phoneRetinaViewController;
                padViewController = nil;
                phoneViewController = nil;
            }
			else {
				self.window.rootViewController = self.phoneViewController;
                padViewController = nil;
                phoneRetinaViewController = nil;
            }

	}
	
    [self.window makeKeyAndVisible];
	
	
    return YES;
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    
//Each view controller has an accessor method to handle the switch to the background state. It's called when the applicationDidEnterBackground method is called in the Delegate. Also the idleTimerDisabled is switched back to NO.
    
	application.idleTimerDisabled = NO;
	if (application.applicationState == UIApplicationStateBackground) {
		[phoneViewController appToBackground];
		[padViewController appToBackground];
		[phoneRetinaViewController appToBackground];
	}
	
}
- (void)applicationDidEnterForeground:(UIApplication *)application{
	application.idleTimerDisabled = YES;
}
- (void)applicationWillTerminate:(UIApplication *)application {
	application.idleTimerDisabled = NO;
}

- (void)dealloc {
	[phoneRetinaViewController release];
    [phoneViewController release];
	[padViewController release];
    [window release];
    [super dealloc];
}


@end

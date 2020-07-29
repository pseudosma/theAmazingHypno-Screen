//
//  AppDelegate.h
//  The Amazing Hypno-Screen
//
//  Created by David Paige on 6/16/12.
//  Copyright 2012 Appbastard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 

//This app has an intended deployment on the iPhone, iPhonw w/ retina, and iPad(Gen1 and 2). There is a seperate view controller for each device.

@class iPhoneViewController;
@class iPadViewController;
@class iPhoneRetinaViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window;
	iPhoneViewController *phoneViewController;
	iPadViewController *padViewController;
	iPhoneRetinaViewController *phoneRetinaViewController;
}

@property (nonatomic,retain) IBOutlet UIWindow *window;
@property (nonatomic,retain) IBOutlet iPhoneViewController *phoneViewController;
@property (nonatomic,retain) IBOutlet iPadViewController *padViewController;
@property (nonatomic,retain) IBOutlet iPhoneRetinaViewController *phoneRetinaViewController;

@end

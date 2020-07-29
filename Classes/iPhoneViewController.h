//
//  iPhoneViewController.h
//  The Amazing Hypno-Screen
//
//  Created by David Paige on 6/16/12.
//  Copyright 2012 Appbastard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface iPhoneViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
	//picker related 
	NSArray *spiralType;
	NSArray *colorType;
	UIPickerView *picker;
	NSString *colorTypeString;
	NSString *spiralTypeString;
	
	//interface UIKit related 
	UIButton *hypnotizeButton;
	UISwitch *clockwise;
	float clockwiseValue;
	
	//background related
	CABasicAnimation *counterClockwiseGear;
	CABasicAnimation *clockwiseGear;
	UIImageView *imageView;
	UIView *gear1View;
	UIView *gear2View;
	UIView *gear3View;
	UIImageView *gear1ImageView;
	UIImageView *gear2ImageView;
	UIImageView *gear3ImageView;
	
	//hypnoscreen related
	UIView *hypnoScreen;
	CABasicAnimation *animationA;
	CABasicAnimation *animationB;
	UIImage *spiralImage;
	UIImageView *spiralImageView;
	UIImage *spiralImage2;
	UIImageView *spiralImageView2;
    
}

-(void)appToBackground;

@end

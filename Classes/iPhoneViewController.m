//
//  iPhoneViewController.m
//  The Amazing Hypno-Screen
//
//  Created by David Paige on 6/16/12.
//  Copyright 2012 Appbastard. All rights reserved.
//

#import "iPhoneViewController.h"


@implementation iPhoneViewController

-(void)backgroundViews{
    
//This method populates a background for the app. Three gears are created as UIImageViews placed into UIViews to facilitate proper sizing. They're giving rotation animation (either clockwise or counter-clockwise) and a semi-transparent UIImageView is placed above. All make up the lower layers of self.view's hierarchy.
    
	clockwiseGear = [CABasicAnimation animationWithKeyPath:@"transform"];
	clockwiseGear.fromValue = [NSNumber numberWithFloat:0];
	clockwiseGear.toValue = [NSNumber numberWithFloat:M_PI * 2];
	clockwiseGear.duration = 24;
	clockwiseGear.additive = YES;
	clockwiseGear.repeatCount = INFINITY;
	clockwiseGear.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
	
	counterClockwiseGear = [CABasicAnimation animationWithKeyPath:@"transform"];
	counterClockwiseGear.fromValue = [NSNumber numberWithFloat:0];
	counterClockwiseGear.toValue = [NSNumber numberWithFloat:-M_PI * 2];
	counterClockwiseGear.duration = 8;
	counterClockwiseGear.additive = YES;
	counterClockwiseGear.repeatCount = INFINITY;
	counterClockwiseGear.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
	
	UIImage *gear1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"iphone_gear_1.png" ofType:nil]];
	
	gear1ImageView = [[UIImageView alloc] initWithImage:gear1];
	gear1View = [[UIView alloc]initWithFrame:CGRectMake(-120, -100, 389, 388)];
	[gear1View addSubview:gear1ImageView];
	[self.view addSubview:gear1View];
	[gear1View.layer addAnimation:clockwiseGear forKey:nil];
	
	UIImage *gear2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"iphone_gear_2.png" ofType:nil]];
	
	gear2ImageView = [[UIImageView alloc] initWithImage:gear2];
	gear2View = [[UIView alloc]initWithFrame:CGRectMake(20, 250, 310, 313)];
	[gear2View addSubview:gear2ImageView];
	[self.view addSubview:gear2View];
	[gear2View.layer addAnimation:counterClockwiseGear forKey:nil];
	
	UIImage *gear3 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"iphone_gear_3.png" ofType:nil]];
	
	gear3ImageView = [[UIImageView alloc] initWithImage:gear3];
	gear3View = [[UIView alloc]initWithFrame:CGRectMake(60, 220, 356, 356)];
	[gear3View addSubview:gear3ImageView];
	[self.view insertSubview:gear3View belowSubview:gear2View];
	[gear3View.layer addAnimation:clockwiseGear forKey:nil];
	
	UIImage *image1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hypnotize_menu_iphone.png" ofType:nil]];
	
	imageView = [[UIImageView alloc] initWithImage:image1];
	
	[self.view addSubview:imageView];
    
//retain is called for the animations so that they can be resumed when the app enters the foreground (rather than having a reference count of -1).
    
    [clockwiseGear retain];
    [counterClockwiseGear retain];

}

-(void)addSubview{
    
//This is the start of the pickerView's methods. Two arrays populate the two components with strings. Picker delegation and the datasource are defined in this implementation file aswell.
	
	spiralType = [[NSArray alloc] initWithObjects:@"Basic", @"Squared", @"Jagged", @"Complex",nil];
	colorType = [[NSArray alloc] initWithObjects:@"Standard",@"Red",@"Green",@"Blue",@"Orange",@"Purple",nil];
	
	picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
	picker.showsSelectionIndicator = YES;
	picker.delegate = self;
	picker.dataSource = self;
	
	[self.view addSubview:picker];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
	return 150.0;	
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	
	NSString *returnStr = @"";
	
	if (component == 0)
	{
		returnStr = [colorType objectAtIndex:row];
	}
	else
	{
		returnStr = [spiralType objectAtIndex:row];
	}
	
	return returnStr;	
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
	return 40.0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

	if (component ==0) {
		return [colorType count];
	}
	else {
		return [spiralType count];
	}
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	colorTypeString = [colorType objectAtIndex:[pickerView selectedRowInComponent:0]];
	spiralTypeString = [spiralType objectAtIndex:[pickerView selectedRowInComponent:1]];
}

-(void)addButtonSubview{
    
//This method defines the green hypnotize button, its location, and the selector for its action.
    
	hypnotizeButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	
	UIImage *buttonImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hypnotize_button_iphone.png" ofType:nil]];
	hypnotizeButton.frame = CGRectMake(169.0, 323.0, buttonImage.size.width, buttonImage.size.height);
	[hypnotizeButton setImage:buttonImage forState:UIControlStateNormal];
	[hypnotizeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview:hypnotizeButton];
}

-(void)addSwitchSubview{
    
//This method deefines the switch's location and selector method. The selector method only changes the value of the int clockwiseValue from one to negative one; that, in turn, is multiplied by the animated spiral's rotation value to change it clockwise or counter-clockwise.
    
	CGRect frame = CGRectMake(120.0, 271.0, 94.0, 27.0);
	clockwise = [[UISwitch alloc] initWithFrame:frame];
	clockwise.on = NO;
	[clockwise addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:clockwise];
	clockwiseValue = 1;
}

-(void)switchAction:(id)sender{
	if (clockwise.on) {
		clockwiseValue = -1;
	}
	else {
		clockwiseValue = 1;
	}
}

-(void)buttonAction:(id)sender{
    
//This method is called when the button is pushed. When it's called a series of if statements choose a course of actions based on which strings are selected from the picker's arrays. A spiral is created from a UIImageView layered in a UIVIew. Color change happens by changing the background color of the UIView and making the UIImageView semi-transparent. Also a gesture recognizer is added to remove the views from self.view's hierarchy when the user chooses.
	
	CGRect hypnoScreenFrame = CGRectMake(-290, -210, 900, 900);
	
	if (spiralTypeString == @"Squared" || spiralTypeString == @"Jagged") {
		hypnoScreenFrame = CGRectMake(-340, -260, 1000, 1000);
	}
	
	hypnoScreen = [[UIView alloc] initWithFrame:hypnoScreenFrame];
	 
		if (colorTypeString == @"Red") {
		hypnoScreen.backgroundColor = [UIColor redColor];
		}
		if (colorTypeString == @"Green") {
		hypnoScreen.backgroundColor = [UIColor greenColor];
		}
		if (colorTypeString == @"Blue") {
		hypnoScreen.backgroundColor = [UIColor blueColor];
		}
		if (colorTypeString == @"Orange") {
		hypnoScreen.backgroundColor = [UIColor orangeColor];
		}
		if (colorTypeString == @"Purple") {
		hypnoScreen.backgroundColor = [UIColor purpleColor];
		}
	
	[self.view addSubview:hypnoScreen];
	
		if (spiralTypeString == @"Basic" || spiralTypeString == nil){
		spiralImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"archimedes_spiral_iphone.png" ofType:nil]];
		}
		if (spiralTypeString == @"Squared") {
		spiralImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"squared_spiral_iphone.png" ofType:nil]];
		}
		if (spiralTypeString == @"Jagged") {
		spiralImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"jagged_spiral_iphone.png" ofType:nil]];
		}
		if(spiralTypeString == @"Complex"){
		spiralImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"archimedes_spiral_iphone.png" ofType:nil]];
		spiralImage2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"archimedes_spiral_iphone.png" ofType:nil]];
		}
	
	spiralImageView = [[UIImageView alloc] initWithImage:spiralImage];
	
		if (spiralImage2 != nil) {
		spiralImageView2 = [[UIImageView alloc] initWithImage:spiralImage2];
		}
	
	[hypnoScreen addSubview:spiralImageView];
	
	animationA = [CABasicAnimation animationWithKeyPath:@"transform"];
	animationA.fromValue = [NSNumber numberWithFloat:0];
	animationA.toValue = [NSNumber numberWithFloat:-M_PI * 2 * clockwiseValue ];
	animationA.duration = 3.0;
	animationA.additive = YES;
	animationA.repeatCount = INFINITY;
	animationA.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];

//animationB is used only for the complex spiral.
    
	animationB = [CABasicAnimation animationWithKeyPath:@"transform"];
	animationB.fromValue = [NSNumber numberWithFloat:0];
	animationB.toValue = [NSNumber numberWithFloat:M_PI * 2 * clockwiseValue ];
	animationB.duration = 6;
	animationB.additive = YES;
	animationB.repeatCount = INFINITY;
	animationB.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
		
		if (spiralTypeString == @"Squared" || spiralTypeString == @"Jagged") {
			[UIView animateWithDuration:4 delay:0 options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionAllowUserInteraction
			animations:^{ 
				spiralImageView.transform = CGAffineTransformMakeScale(0.7, 0.7);}
			completion:nil];
			 }
	
		if (spiralImageView2 !=nil) {
		[hypnoScreen addSubview:spiralImageView2];
		spiralImageView2.alpha = 0.5;
		[spiralImageView2.layer addAnimation:animationB forKey:nil];
		}
	
		if (colorTypeString == @"Standard" || colorTypeString == nil) {
		spiralImageView.alpha = 1;
		}
		else {
		spiralImageView.alpha = 0.5;
		}

	hypnoScreen.clipsToBounds = YES;
	spiralImageView.userInteractionEnabled = YES;
	[hypnoScreen.layer addAnimation:animationA forKey:nil];
	
	UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
	[hypnoScreen addGestureRecognizer:tap];
	
	[tap autorelease];
}

-(void)tap:(id)sender{
    
//selector method for the gesture recognizer previously added to the button's selector method.
    
	[hypnoScreen removeFromSuperview];
	spiralImage2 = nil;
	spiralImageView2 = nil;
}

-(void)appToBackground{
    
//This is the one accessor method for this object. It removes the layer animations before sending it to the bgackground.
    
	[gear1View.layer removeAllAnimations];
	[gear2View.layer removeAllAnimations];
	[gear3View.layer removeAllAnimations];
	[hypnoScreen.layer removeAllAnimations];
	[hypnoScreen removeFromSuperview];
	spiralImage2 = nil;
	spiralImageView2 = nil;
}

-(void)appToForeground{
    
//Accessor methods placed in the delegate's applicationWillEnterForeground method won't respond so the previously removed animations are readded via NSNotification. This method becomes the notification's selector method.
    
	[gear1View.layer addAnimation:clockwiseGear forKey:nil];
	[gear2View.layer addAnimation:counterClockwiseGear forKey:nil];
	[gear3View.layer addAnimation:clockwiseGear forKey:nil];
}

- (void)didReceiveMemoryWarning {
    
//Background animations are removed when a memory warning occurs.
    
	[super didReceiveMemoryWarning];
	[gear1View.layer removeAllAnimations];
	[gear2View.layer removeAllAnimations];
	[gear3View.layer removeAllAnimations];
	
}

-(void)viewDidLoad{
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
	selector:@selector(appToForeground)
	name:UIApplicationWillEnterForegroundNotification 
    object: [UIApplication sharedApplication]];
	
	self.view.opaque = YES;
	self.view.clipsToBounds = YES;
	[self backgroundViews];
	[self addSubview];
	[self addButtonSubview];
	[self addSwitchSubview];
}
- (void)viewDidUnload {
	[[NSNotificationCenter defaultCenter] removeObserver:self 
	name:UIApplicationWillEnterForegroundNotification 
    object:nil];
	
	imageView = nil;
	picker = nil;
	hypnotizeButton = nil;
	clockwise = nil;
	hypnoScreen = nil;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	//background views and animations
	[clockwiseGear release];
	[counterClockwiseGear release];
	[gear1View release];
	[gear2View release];
	[gear3View release];
	[gear1ImageView release];
	[gear2ImageView release];
	[gear3ImageView release];
	[imageView release];
	//interface
	[picker release];
	[spiralType release];
	[colorType release];
	[hypnotizeButton release];
	[clockwise release];
	[colorTypeString release];
	[spiralTypeString release];
	//hypnoscreen view, images, and animations
	[spiralImage release];
	[spiralImageView release];
	[animationA release];
	[animationB release];
	[hypnoScreen release];
	[spiralImage2 release];
	[spiralImageView2 release];

	[super dealloc];
}


@end

//
//  iPhoneRetinaViewController.m
//  The Amazing Hypno-Screen
//
//  Created by David Paige on 6/16/12.
//  Copyright 2012 Appbastard. All rights reserved.
//

#import "iPhoneRetinaViewController.h"


@implementation iPhoneRetinaViewController

-(void)imageView{
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
	
	UIImage *gear1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"retina_gear_1@2x.png" ofType:nil]];
	
	gear1ImageView = [[UIImageView alloc] initWithImage:gear1];
	gear1View = [[UIView alloc]initWithFrame:CGRectMake(-120, -100, 343, 343.5)];
	[gear1View addSubview:gear1ImageView];
	[self.view addSubview:gear1View];
	[gear1View.layer addAnimation:clockwiseGear forKey:nil];
	
	UIImage *gear2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"retina_gear_2@2x.png" ofType:nil]];
	
	gear2ImageView = [[UIImageView alloc] initWithImage:gear2];
	gear2View = [[UIView alloc]initWithFrame:CGRectMake(30, 250, 276.5, 276)];
	[gear2View addSubview:gear2ImageView];
	[self.view addSubview:gear2View];
	[gear2View.layer addAnimation:counterClockwiseGear forKey:nil];
	
	UIImage *gear3 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"retina_gear_3@2x.png" ofType:nil]];
	
	gear3ImageView = [[UIImageView alloc] initWithImage:gear3];
	gear3View = [[UIView alloc]initWithFrame:CGRectMake(60, 220, 314.5, 314.5)];
	[gear3View addSubview:gear3ImageView];
	[self.view insertSubview:gear3View belowSubview:gear2View];
	[gear3View.layer addAnimation:clockwiseGear forKey:nil];
	
	UIImage *image1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hypnotize_menu_retina@2x.png" ofType:nil]];
	
	imageView = [[UIImageView alloc] initWithImage:image1];

	[self.view addSubview:imageView];
    [clockwiseGear retain];
    [counterClockwiseGear retain];
	
}

-(void)addSubview{
	
	spiralType = [[NSArray alloc] initWithObjects:@"Basic", @"Squared", @"Jagged", @"Complex",nil];
	colorType = [[NSArray alloc] initWithObjects:@"Standard",@"Red",@"Green",@"Blue",@"Orange",@"Purple",nil];
	
	picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
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
	hypnotizeButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	
	UIImage *buttonImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hypnotize_button_retina@2x.png" ofType:nil]];
	hypnotizeButton.frame = CGRectMake(191.0, 338.0, buttonImage.size.width, buttonImage.size.height);
	[hypnotizeButton setImage:buttonImage forState:UIControlStateNormal];
	[hypnotizeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview:hypnotizeButton];
}

-(void)addSwitchSubview{
	CGRect frame = CGRectMake(116.0, 275.0, 94.0, 27.0);
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
	
	CGRect hypnoScreenFrame = CGRectMake(-140, -60, 600, 600);
	
	if (spiralTypeString == @"Squared" || spiralTypeString == @"Jagged") {
		hypnoScreenFrame = CGRectMake(-215, -135, 750, 750);
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
		spiralImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"archimedes_spiral_retina@2x.png" ofType:nil]];
	}
	if (spiralTypeString == @"Squared") {
		spiralImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"squared_spiral_retina@2x.png" ofType:nil]];
	}
	if (spiralTypeString == @"Jagged") {
		spiralImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"jagged_spiral_retina@2x.png" ofType:nil]];
	}
	if(spiralTypeString == @"Complex"){
		spiralImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"archimedes_spiral_retina@2x.png" ofType:nil]];
		spiralImage2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"archimedes_spiral_retina@2x.png" ofType:nil]];
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
							 spiralImageView.transform = CGAffineTransformMakeScale(0.8, 0.8);}
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
	[hypnoScreen removeFromSuperview];
	spiralImage2 = nil;
	spiralImageView2 = nil;
}

-(void)appToBackground{
	[gear1View.layer removeAllAnimations];
	[gear2View.layer removeAllAnimations];
	[gear3View.layer removeAllAnimations];	
	[hypnoScreen.layer removeAllAnimations];
	[hypnoScreen removeFromSuperview];
	spiralImage2 = nil;
	spiralImageView2 = nil;
	
}

-(void)appToForeground{
	[gear1View.layer addAnimation:clockwiseGear forKey:nil];
	[gear2View.layer addAnimation:counterClockwiseGear forKey:nil];
	[gear3View.layer addAnimation:clockwiseGear forKey:nil];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	[gear1View.layer removeAllAnimations];
	[gear2View.layer removeAllAnimations];
	[gear3View.layer removeAllAnimations];
	
}

-(void)viewDidLoad{
	[[NSNotificationCenter defaultCenter] addObserver:self 
	selector:@selector(appToForeground)
	name:UIApplicationWillEnterForegroundNotification 
	object:[UIApplication sharedApplication]];
	
	self.view.clipsToBounds = YES;
	self.view.opaque = YES;
	[self imageView];
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


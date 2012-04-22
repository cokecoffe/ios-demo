//
//  TimerController.m
//  Invocations
//

#import "TimerController.h"


@implementation TimerController

- (id)init
{
	self = [super init];
	if (!self) return nil;
	count = 0;
	return self;
}

- (void)awakeFromNib
{
	count = [startCount intValue];
	[currentCount setIntValue:count];
	[self stopTimer];
}

- (void)dealloc
{
	[self stopTimer];
   [super dealloc];
}

- (void)startTimer
{
	if (myTimer) {
		[self stopTimer];
	}
	myTimer = [NSTimer scheduledTimerWithTimeInterval:[interval doubleValue]
											   target:self selector:@selector(count:)
											 userInfo:nil repeats:YES];
	[myTimer retain];
	[startButton setEnabled:NO];
	[continueButton setEnabled:NO];
	[endButton setEnabled:YES];
}

- (void)stopTimer
{
	[myTimer invalidate];
	[myTimer release];
	myTimer = nil;
	[startButton setEnabled:YES];
	if ((count > [startCount intValue]) && (count < [endCount intValue])) {
		[continueButton setEnabled:YES];
	} else {
		[continueButton setEnabled:NO];
	}
	[endButton setEnabled:NO];
}

- (IBAction)startTimer:(id)sender
{
	count = [startCount intValue];
	[currentCount setIntValue:count];
	[self startTimer];
}

- (IBAction)continueTimer:(id)sender
{
	if (!myTimer) {
		[self startTimer];
	} 
}

- (IBAction)endTimer:(id)sender
{
	[self stopTimer];
}

- (void)count:(id)userInfo
{
	if (count >= [endCount intValue]) {
		[self stopTimer];
	} else {
		count++;
		[currentCount setIntValue:count];
	}
}

@end

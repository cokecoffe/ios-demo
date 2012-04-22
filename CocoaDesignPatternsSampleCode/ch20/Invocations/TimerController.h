//
//  TimerController.h
//  Invocations
//

#import <Cocoa/Cocoa.h>


@interface TimerController : NSObject
{
	NSTimer *myTimer;
	IBOutlet NSTextField *startCount;
	IBOutlet NSTextField *endCount;
	IBOutlet NSTextField *interval;
	IBOutlet NSTextField *currentCount;
	IBOutlet NSButton *startButton;
	IBOutlet NSButton *continueButton;
	IBOutlet NSButton *endButton;
	int count;
}

- (void)startTimer;
- (void)stopTimer;
- (IBAction)startTimer:(id)sender;
- (IBAction)continueTimer:(id)sender;
- (IBAction)endTimer:(id)sender;
- (void)count:(id)userInfo;

@end

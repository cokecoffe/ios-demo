//
//  AlertController.m
//  Invocations
//
//

#import "AlertController.h"


@implementation AlertController

- (IBAction)openAlert:(id)sender
{
	NSRunAlertPanel (@"Alert", @"This is an alert.", @"OK", nil, nil);
}

- (IBAction)openDelayedAlert:(id)sender
{
	[self performSelector:@selector(openAlert:) withObject:sender afterDelay:0.0];
}

@end

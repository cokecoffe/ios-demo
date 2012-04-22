#import "MyResponderChainTracer.h"


@implementation MyResponderChainTracer

- (void)traceChain:(id)currentResponder
{
	while (currentResponder) {
		NSLog(@"Responder %d:  %@", count, currentResponder);
		count++;
		if ([currentResponder isKindOfClass:[NSWindow class]] || [currentResponder isKindOfClass:[NSApplication class]]) {
			id delegate = [currentResponder delegate];
			if (delegate) {
				NSLog(@"Responder %d (delegate):  %@", count, [currentResponder delegate]);
				count++;
			}
		}
		if ([currentResponder respondsToSelector:@selector(nextResponder)]) {
			currentResponder = [currentResponder nextResponder];
		} else {
			currentResponder = nil;
		}
	}
}

- (IBAction)trace:(id)sender
{
	NSWindow *keyWindow = [NSApp keyWindow];
	NSWindow *mainWindow = [NSApp mainWindow];
	count = 1;
	NSLog(@"***** Begin Trace *****");
	[self traceChain:[keyWindow firstResponder]];
	if (keyWindow != mainWindow) {
		[self traceChain:[mainWindow firstResponder]];
	}
	[self traceChain:NSApp];
	[self traceChain:[NSDocumentController sharedDocumentController]];
	NSLog(@"***** End Trace *****");
}

@end

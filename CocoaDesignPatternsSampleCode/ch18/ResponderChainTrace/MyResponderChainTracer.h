#import <Cocoa/Cocoa.h>


@interface MyResponderChainTracer : NSObject
{
	int count;
}

- (void)traceChain:(id)currentResponder;
- (IBAction)trace:(id)sender;

@end

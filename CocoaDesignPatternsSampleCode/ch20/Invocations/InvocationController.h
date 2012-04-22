//
//  InvocationController.h
//  Invocations
//

#import <Cocoa/Cocoa.h>


@interface InvocationController : NSObject
{
	IBOutlet NSTextField *receiver;
	IBOutlet NSPopUpButton *message;
	IBOutlet NSTextField *argument1;
	IBOutlet NSTextField *argument2;
	IBOutlet NSTextField *result;
}

- (IBAction)inputChanged:(id)sender;
- (IBAction)sendMessage:(id)sender;

@end

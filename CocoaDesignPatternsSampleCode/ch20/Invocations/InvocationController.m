//
//  InvocationController.m
//  Invocations
//

#import "InvocationController.h"


@implementation InvocationController

- (IBAction)inputChanged:(id)sender
{
	int numberOfArguments = [[message selectedItem] tag];
	[argument1 setEnabled:NO];
	[argument2 setEnabled:NO];
	switch (numberOfArguments) {
		case 2:
			[argument2 setEnabled:YES];
		case 1:
			[argument1 setEnabled:YES];
		case 0:
		default:
			break;
	}
}

- (IBAction)sendMessage:(id)sender
{
	// get the receiver
	NSString *receivingString = [receiver stringValue];
	// create an invocation from the pop up button's title
	NSString *messageString = [message titleOfSelectedItem];
	SEL selector = NSSelectorFromString(messageString);
	NSMethodSignature *methodSignature = [receivingString methodSignatureForSelector:selector];
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
	[invocation setTarget:receivingString];  // argument 0 is "self"
	[invocation setSelector:selector]; // argument 1 is "_cmd"
	// Set up the rest of the message's arguments.  Since indices 0 and 1 are reserved
	// for the self and _cmd hidden arguments,  we start at index 2.  We also cannot
	// use actual objects, we must use pointers to objects.
	int numberOfArguments = [[message selectedItem] tag];
	if (numberOfArguments > 0) {
		NSString *argumentString1 = [argument1 stringValue];
		[invocation setArgument:&argumentString1 atIndex:2];
		if (numberOfArguments > 1) {
			NSString *argumentString2 = [argument2 stringValue];
			[invocation setArgument:&argumentString2 atIndex:3];
		}
	}
	// send the message
	[invocation invoke];
	// get the return value
	void *returnValue = NULL;
	[invocation getReturnValue:&returnValue];
	// find out the type of the return value so we can handle it correctly
	const char *returnType = [methodSignature methodReturnType];
	if (returnType) {
		switch (returnType[0]) {
			case '@':
				[result	setObjectValue:(id)returnValue];
				break;
			case 'i':
				[result	setIntValue:(int)returnValue];
				break;

			default:
				break;
		}
	}
}

@end

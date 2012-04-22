#import "MYCommand.h"
#import "MYStack.h"


@implementation MYCommand

+ (MYCommandReturn)executeWithStack:(MYStack *)stack;
{
	NSLog(@"%@:  not implemented yet.\n", [self className]);
	return MYError;
}

@end

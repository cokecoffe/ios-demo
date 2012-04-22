#import "MYPrintCommand.h"
#import "MYStack.h"


@implementation MYPrintCommand

+ (MYCommandReturn)executeWithStack:(MYStack *)stack
{
	if ([stack count] < 1) return MYError;
	fprintf(stdout,	"%s\n", [[stack peekAtIndex:0] cStringUsingEncoding:NSASCIIStringEncoding]);
	return MYSuccess;
}

@end

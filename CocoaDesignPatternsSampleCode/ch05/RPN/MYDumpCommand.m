#import "MYDumpCommand.h"
#import "MYStack.h"


@implementation MYDumpCommand

+ (MYCommandReturn)executeWithStack:(MYStack *)stack
{
	int count = [stack count];
	int i;
	for (i=0; i<count; i++) {
		NSString *value = [stack peekAtIndex:i];
		fprintf(stdout,	"%d: \"%s\"\n", i, [value cStringUsingEncoding:NSASCIIStringEncoding]);
	}
	return MYSuccess;
}

@end


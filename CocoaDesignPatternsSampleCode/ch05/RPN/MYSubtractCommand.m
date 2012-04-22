#import "MYSubtractCommand.h"
#import "MYStack.h"


@implementation MYSubtractCommand

+ (MYCommandReturn)executeWithStack:(MYStack *)stack
{
	if ([stack count] < 2) return MYError;
	NSString *value1 = [stack pop];
	NSString *value2 = [stack pop];
	double result = [value2 doubleValue] - [value1 doubleValue];
	NSString *resultString = [NSString stringWithFormat:@"%f", result];
	[stack push:resultString];
	return MYSuccess;
}

@end

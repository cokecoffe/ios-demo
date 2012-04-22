#import "MYQuitCommand.h"


@implementation MYQuitCommand

+ (MYCommandReturn)executeWithStack:(MYStack *)stack
{
	return MYHaltExecution;
}

@end

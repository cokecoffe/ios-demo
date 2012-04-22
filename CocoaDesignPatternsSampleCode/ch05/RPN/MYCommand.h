#import <Cocoa/Cocoa.h>

@class MYStack;

typedef enum {
	MYSuccess = 0,
	MYError = 1,
	MYHaltExecution = 2
} MYCommandReturn;

@interface MYCommand : NSObject
{
}

+ (MYCommandReturn)executeWithStack:(MYStack *)stack;

@end

#import <Cocoa/Cocoa.h>


@interface MYJunction : NSProxy
{
	NSMutableArray *targets;
}

+ (MYJunction *)sharedJunction;
- (void)addTarget:(id)anObject;

@end

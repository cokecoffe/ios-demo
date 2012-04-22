#import "MYJunction.h"


@implementation MYJunction

+ (MYJunction *)sharedJunction
{
	static MYJunction *sharedJunction = nil;
	if (!sharedJunction) {
		sharedJunction = [[MYJunction alloc] init];
	}
	return sharedJunction;
}

- (id)init
{
	targets = [[NSMutableArray alloc] init];
	return self;
}

- (void)dealloc
{
	[targets release];
	[super dealloc];
}

- (void)addTarget:(id)anObject
{
	[targets addObject:anObject];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
	id target;
	for (target in targets) {
		if ([target respondsToSelector:aSelector]) {
			return [target methodSignatureForSelector:aSelector];
		}
	}
	return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
	if ([[anInvocation methodSignature] numberOfArguments] > 2) {
		id target;
		for (target in targets) {
			id messageSender = nil;
			[anInvocation getArgument:&messageSender atIndex:2];
			if (messageSender != target) {
				[anInvocation invokeWithTarget:target];
			}
		}
	}
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
	id target;
	for (target in targets) {
		if ([target conformsToProtocol:aProtocol]) {
			return YES;
		}
	}
	return NO;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
	id target;
	for (target in targets) {
		if ([target respondsToSelector:aSelector]) {
			return YES;
		}
	}
	return NO;
}

@end

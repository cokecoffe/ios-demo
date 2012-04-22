#import "MYTrampoline.h"

@implementation NSObject(MYTrampoline)

- (NSMethodSignature *)findMethodSignatureForSelector:(SEL)aSelector
{
	return [self methodSignatureForSelector:aSelector];
}

@end


@implementation MYTrampoline

+ (id)trampolineForTarget:(id)aTarget andSelector:(SEL)aSelector
{
	id newTrampoline = [[[self class] alloc] initForTarget:aTarget andSelector:aSelector];
	[newTrampoline autorelease];
	return newTrampoline;
}

- (id)initForTarget:(id)aTarget andSelector:(SEL)aSelector
{
	target = aTarget;
	[target retain];
	selector = aSelector;
	return self;
}

- (void)dealloc
{
	[target release];
	[super dealloc];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
	return [target findMethodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
	[target performSelector:selector withObject:anInvocation];
}

@end

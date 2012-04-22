#import "NSArray+HOM.h"
#import "MYTrampoline.h"


@implementation NSArray(HOM)

- (NSMethodSignature *)findMethodSignatureForSelector:(SEL)aSelector
{
	for (id object in self) {
		if ([object respondsToSelector:aSelector]) {
			return [object methodSignatureForSelector:aSelector];
		}
	}
	return [self methodSignatureForSelector:aSelector];
}

- (id)makeObjectsPerform
{
	return [MYTrampoline trampolineForTarget:self andSelector:@selector(makeObjectsPerformInvocation:)];
}

- (void)makeObjectsPerformInvocation:(NSInvocation *)invocation
{
	id object = nil;
	for (object in self) {
		[invocation invokeWithTarget:object];
	}
}

@end

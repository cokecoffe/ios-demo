#import "MYStack.h"


@implementation MYStack

- (id)init
{
	self = [super init];
	if (self) {
		storage = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[storage release];
	[super dealloc];
}

- (void)push:(id)anObject
{
	if (anObject) [storage addObject:anObject];
}

- (id)pop
{
	id value = nil;
	if ([storage count] > 0) {
		value = [storage lastObject];
		[value retain];
		[storage removeObjectAtIndex:([storage count] - 1)];
		[value autorelease];
	}
	return value;
}

- (NSInteger)count
{
	return [storage count];
}

- (id)peekAtIndex:(NSInteger)index
{
	id value = nil;
	if (index < [self count]) {
		value = [storage objectAtIndex:([storage count] - 1) - index];
	}
	return value;
}

@end

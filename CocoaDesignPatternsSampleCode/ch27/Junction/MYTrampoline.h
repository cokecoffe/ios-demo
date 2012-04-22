#import <Foundation/Foundation.h>

@interface NSObject(MYTrampoline)

- (NSMethodSignature *)findMethodSignatureForSelector:(SEL)aSelector;

@end

@interface MYTrampoline : NSProxy
{
	id target;
	SEL	selector;
}

+ (id)trampolineForTarget:(id)aTarget andSelector:(SEL)aSelector;
- (id)initForTarget:(id)aTarget andSelector:(SEL)aSelector;

@end

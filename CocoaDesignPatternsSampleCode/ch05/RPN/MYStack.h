#import <Cocoa/Cocoa.h>


@interface MYStack : NSObject
{
	NSMutableArray *storage;
}

- (void)push:(id)anObject;
- (id)pop;
- (NSInteger)count;
- (id)peekAtIndex:(NSInteger)index;

@end

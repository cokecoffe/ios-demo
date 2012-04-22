#import "MYLinkedListEnumerator.h"
#import "MYLinkedList.h"
#import "MYLinkedListNode.h"


@implementation MYLinkedListEnumerator

@synthesize list;
@synthesize currentNode;
@synthesize originalListLength;

- (id)initForList:(MYLinkedList *)theList
{
	self = [super init];
	self.list = theList;
	self.currentNode = theList.firstNode;
	originalListLength = theList.listLength;
	return self;
}

/*  This is no better than the default implementation, and probably worse:
- (NSArray *)allObjects
{
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:originalListLength];
	id object;
	// fill the array with all remaining objects to be enumerated
	while ((object = [self nextObject])) {
		[array addObject:object];
	}
	return array;
}
*/

- (id)nextObject
{
	id object = nil; // we return nil if at the end of the list
	MYLinkedListNode *nextNode = self.currentNode.nextNode;
	if (list.listLength != self.originalListLength) {
		NSException *exception = [NSException exceptionWithName:@"MYLinkedListMutationException"
                            reason:@"MYLinkedList was mutated during an enumeration" userInfo:nil];
		@throw exception;
	}
	if (self.currentNode != self.list.markerNode) {
		// still nodes left to traverse, so return this one and get next
		object = self.currentNode.object;
		self.currentNode = nextNode;
	}
	return object;
}

@end

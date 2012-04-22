#import <Foundation/Foundation.h>

@class MYLinkedListNode;

@interface MYLinkedList : NSObject <NSFastEnumeration>
{
	unsigned long listLength;
	MYLinkedListNode *firstNode;
	MYLinkedListNode *lastNode;
	// placed in linked list after last node to mark end of list
	// (we can't mark the end with a nil becuase of NSFastEnumeration)
	MYLinkedListNode *markerNode;
}

- (void)appendObject:(id)newObject;
- (NSEnumerator *)objectEnumerator;

@property (readwrite, retain) MYLinkedListNode *firstNode;
@property (readwrite, retain) MYLinkedListNode *lastNode;
@property (readonly) MYLinkedListNode *markerNode;
@property (readonly) unsigned long listLength;

@end

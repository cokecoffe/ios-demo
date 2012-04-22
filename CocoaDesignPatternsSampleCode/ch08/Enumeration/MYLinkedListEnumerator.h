#import <Foundation/Foundation.h>

@class MYLinkedList;
@class MYLinkedListNode;

@interface MYLinkedListEnumerator : NSEnumerator
{
	MYLinkedList *list;
	MYLinkedListNode *currentNode;
	unsigned long originalListLength;
}

- (id)initForList:(MYLinkedList *)theList;

@property (readwrite, retain) MYLinkedList *list;
@property (readwrite, retain) MYLinkedListNode *currentNode;
@property (readonly) unsigned long originalListLength;

@end

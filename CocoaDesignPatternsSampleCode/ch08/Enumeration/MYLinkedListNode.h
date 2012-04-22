#import <Foundation/Foundation.h>


@interface MYLinkedListNode : NSObject {
	id object;	// the contained object
	MYLinkedListNode *nextNode; // the next object in the linked list
}

@property (readwrite, retain) id object;
@property (readwrite, retain) MYLinkedListNode *nextNode;

@end

#import "MYLinkedList.h"
#import "MYLinkedListNode.h"
#import "MYLinkedListEnumerator.h"


@implementation MYLinkedList

@synthesize firstNode;
@synthesize lastNode;
@synthesize markerNode;
@synthesize listLength;

- init
{
	self = [super init];
	markerNode = [[MYLinkedListNode alloc] init];
	markerNode.object = [NSNull null];
	markerNode.nextNode = nil;
	self.firstNode = self.markerNode;
	self.lastNode = self.markerNode;
	listLength = 0;
	return self;
}

- (void)appendObject:(id)newObject
{
	MYLinkedListNode *newNode = [[MYLinkedListNode alloc] init];
	newNode.object = newObject;
	newNode.nextNode = markerNode;
	if (self.markerNode == self.firstNode) { // first object added to collection
		self.firstNode = newNode;
		self.lastNode = newNode;
	} else {
		self.lastNode.nextNode = newNode;
		self.lastNode = newNode;
	}
	listLength++;
}

- (void)dealloc
{
	MYLinkedListNode *node = firstNode;
	MYLinkedListNode *next = firstNode.nextNode;
	while (node != markerNode) {
		[node release];
		node = next;
		next = next.nextNode;
	}
	firstNode = nil; lastNode = nil;
	[markerNode release]; markerNode = nil;
	[super dealloc];
}

- (NSEnumerator *)objectEnumerator
{
	MYLinkedListEnumerator *enumerator = [[MYLinkedListEnumerator alloc] initForList:self];
	[enumerator autorelease];
	return enumerator;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
		objects:(id *)stackbuf count:(NSUInteger)len
{
    MYLinkedListNode *currentNode;
    if (nil == (MYLinkedListNode *)state->state) {
		// first call, begin at the start of our list
        currentNode = self.firstNode;
    } else { // pick up where we left off
        currentNode = (MYLinkedListNode *)state->state;
    }
    // fill stackbuf with objects from our list until full or we run out
    NSUInteger nodeCount = 0;
    while ((currentNode != self.markerNode) && (nodeCount < len)) {
        stackbuf[nodeCount] = currentNode.object;
        currentNode = currentNode.nextNode;
        nodeCount++;
    }
    state->state = (unsigned long)currentNode;
    state->itemsPtr = stackbuf;
	// this will change if we are mutated so it's a good guard
    state->mutationsPtr = &listLength;
	// Want to see the default batch size?  Try uncommenting this:
	//NSLog(@"Fast enumeration called with buffer size %d; %d objects loaded.", len, nodeCount);
    return nodeCount;

}

@end

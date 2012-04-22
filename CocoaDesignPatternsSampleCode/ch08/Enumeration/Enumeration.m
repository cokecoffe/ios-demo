#import <Foundation/Foundation.h>
#import "MYLinkedList.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	MYLinkedList *list = [[MYLinkedList alloc] init];
	int count;
	id object;
	NSEnumerator *enumerator = nil;

	// create and populate our test list
	for (count = 1; count < 21; count++) {
		[list appendObject:[NSString stringWithFormat:@"String #%d", count]];
	}

	NSLog(@"Normal enumeration");
	enumerator = [list objectEnumerator];
	NSLog(@"The list contains %d objects.", [[enumerator allObjects] count]);
	enumerator = [list objectEnumerator];
	count = 0;
	while ((object = [enumerator nextObject])) {
		count++;
		NSLog(@"%d:  %@", count, object);
	}

	NSLog(@"Fast Enumeration");
	count = 0;
	for (object in list) {
		count++;
		NSLog(@"%d:  %@", count, object);
	}

	NSLog(@"Fast enumeration using normal enumerator");
	enumerator = [list objectEnumerator];
	count = 0;
	for (object in enumerator) {
		count++;
		NSLog(@"%d:  %@", count, object);
	}

	NSLog(@"Normal enumeration cut short");
	enumerator = [list objectEnumerator];
	count = 0;
	while ((object = [enumerator nextObject])) {
		count++;
		NSLog(@"%d:  %@", count, object);
		if (count == 10) {
			NSLog(@"There are %d more objects.", [[enumerator allObjects] count]);
		}
	}

	NSLog(@"Normal enumeration with mutation exception");
	@try {
		enumerator = [list objectEnumerator];
		count = 0;
		while ((object = [enumerator nextObject])) {
			count++;
			NSLog(@"%d:  %@", count, object);
			if (count == 10) [list appendObject:@"Exception #1"];
		}
	}
	@catch (NSException *exception) {
		NSLog(@"Caught %@: %@", [exception name], [exception  reason]);
	}

	NSLog(@"Fast enumeration with mutation exception");
	@try {
		count = 0;
		for (object in list) {
			count++;
			NSLog(@"%d:  %@", count, object);
			if (count == 10) [list appendObject:@"Exception #2"];
		}
	}
	@catch (NSException *exception) {
		NSLog(@"Caught %@: %@", [exception name], [exception  reason]);
	}
	[list release];

	// Enumerators make some seemingly difficult tasks very easy - guess what this does:
	/*  Uncomment this code and try it out!
	NSString *fileName;
	NSMutableArray *resultArray = [NSMutableArray array];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSDirectoryEnumerator *directoryEnumerator = [fileManager enumeratorAtPath:[fileManager currentDirectoryPath]];
	while (nil != (fileName = [directoryEnumerator nextObject])) {
		[resultArray addObject:fileName];
	}
	NSLog(@"Files in current directory:\n%@", resultArray);
	*/
   
   [pool drain];
   return 0;
}

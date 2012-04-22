#import "MyValidatingButton.h"


@implementation MyValidatingButton

- (void)awakeFromNib
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidUpate:) name:NSApplicationDidUpdateNotification object:nil];
}

- (void)applicationDidUpate:(id)userInfo
{
	BOOL validated = NO;
	id myTarget = [NSApp targetForAction:[self action] to:[self target] from:self];
	if (myTarget) validated = YES;
	if ([myTarget respondsToSelector:@selector(validateMenuItem:)]) {
		NSMenuItem *myItem = [[NSMenuItem alloc] initWithTitle:[self title] action:[self action] keyEquivalent:@""];
		validated = [myTarget validateMenuItem:myItem];
		[myItem release];
	}
//	NSLog(@"Target = %@; action = %@; validated = %d", [myTarget class], NSStringFromSelector([self action]), validated);
	if ([self isEnabled] != validated) {
		[self setEnabled:validated];
	}
}

@end

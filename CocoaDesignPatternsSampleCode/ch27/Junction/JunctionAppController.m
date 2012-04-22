#import "JunctionAppController.h"
#import "NSArray+HOM.h"

#define NUMBER_OF_WINDOWS 4

@implementation JunctionAppController

- (id)init
{
	self = [super init];
	if (!self) return nil;
	windowControllers = [[NSMutableArray alloc] init];
	return self;
}

- (void)dealloc
{
	[windowControllers release];
	[super dealloc];
}

- (void)awakeFromNib
{
	int i;
	for (i=0; i<NUMBER_OF_WINDOWS; i++) {
		NSWindowController *controller = [[[NSWindowController alloc] initWithWindowNibName:@"JunctionWindow"] autorelease];
		[windowControllers addObject:controller];
	}
	[self performSelector:@selector(openAllWindows:) withObject:self afterDelay:0.0];
}

- (IBAction)openAllWindows:(id)sender
{
	// HOM version
	[[windowControllers makeObjectsPerform] showWindow:self];
	// classic Cocoa version
	//[windowControllers makeObjectsPerformSelector:@selector(showWindow:) withObject:self];	
}

@end

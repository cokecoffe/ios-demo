#import "MYViewFinderController.h"
#import "MYHighlightingView.h"


@implementation MYViewFinderController

- (id)init
{
	MYHighlightingView *highlightView = nil;
	
	if (nil != (self = [super init])) {
      browserPath = [[NSMutableArray alloc] init];
      highlightWindow = [[NSWindow alloc] initWithContentRect:NSMakeRect(-10.0, 10.0, 5.0, 5.0)
            styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
      [highlightWindow setBackgroundColor: [NSColor clearColor]];
      [highlightWindow setAlphaValue:1.0];
      [highlightWindow setOpaque:NO];
      [highlightWindow setLevel:(NSNormalWindowLevel + 1)];
      highlightView = [[[MYHighlightingView alloc] initWithFrame:NSMakeRect(0.0, 0.0, 5.0, 5.0)] autorelease];
      [highlightView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
      [highlightWindow setContentView:highlightView];
   }

	return self;
}

- (void)dealloc
{
	[highlightWindow orderOut:self];
	[highlightWindow release];
	[browserPath release];
	browserPath = nil;
	[super dealloc];
}

- (void)mainWindowChanged:(id)sender
{
	NSWindow *mainWindow = [NSApp mainWindow];
	if (mainWindow && (viewedWindow != mainWindow)) {
		viewedWindow = mainWindow;
      
		// reload the browser
		[browserPath removeAllObjects];
		[browserPath addObject:[viewedWindow contentView]];
		[browser loadColumnZero];
		[viewClassField setStringValue:@""];
		[windowPositionField setStringValue:@""];
		[sizeField setStringValue:@""];
		[highlightWindow orderOut:self];
		[browser selectRow:0 inColumn:0];
	}
}

// NSApplication delegate methods
- (void)applicationDidUpdate:(NSNotification *)aNotification
{
	[self mainWindowChanged:self];
}

- (void)applicationDidUnhide:(NSNotification *)aNotification
{
	[self mainWindowChanged:self];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self performSelector:@selector(mainWindowChanged:) withObject:self afterDelay:0.0];
}

// NSBrowser delegate methods

- (NSView *)representedViewAtRow:(NSInteger)row column:(NSInteger)column
{
	NSView *representedView = nil;
	if (column == 0) {
		if (row != 0) return nil; // should never happen
		representedView = [browserPath objectAtIndex:0];
	} else {
		NSView *parent = [browserPath objectAtIndex:(column - 1)];
		NSArray *children = [parent subviews];
		int numChildren = [children count];
		if ((row >= 0) && (row < numChildren)) {
			representedView = [children objectAtIndex:row];
		}
	}
	return representedView;
}

- (void)browser:(NSBrowser *)sender willDisplayCell:(id)cell
		  atRow:(NSInteger)row column:(NSInteger)column
{
	NSView *representedView = [self representedViewAtRow:row column:column];
	if (representedView) {
		[cell setTitle:[representedView className]];
		[cell setLeaf:(([[representedView subviews] count] > 0) ? NO : YES)];
	} else { // should never happen
		[cell setTitle:@"Error"];
		[cell setLeaf:YES];
	}
	[cell setLoaded:YES];
}

- (BOOL)browser:(NSBrowser *)sender selectRow:(NSInteger)row inColumn:(NSInteger)column
{
	if ((row < 0) || (column < 0)) return NO;
	if (column == 0) {
		while ([browserPath count] > 1) {
			[browserPath removeLastObject];
		}
	} else {
		NSView *representedView = [self representedViewAtRow:row column:column];
		while ([browserPath count] > column) {
			[browserPath removeLastObject];
		}
		if (!representedView) { // should never happen
			return NO;
		}
		[browserPath addObject:representedView];
	}
	return YES;
}

- (NSInteger)browser:(NSBrowser *)sender numberOfRowsInColumn:(NSInteger)column
{
	int ret = 0;
	int columnCount = [browserPath count];
	if (column >= columnCount) {
		[self browser:sender selectRow:[sender selectedRowInColumn:(column - 1)]
           inColumn:(column - 1)];
		columnCount = [browserPath count];
		if (column > columnCount) {
			NSLog(@"browser:numberOfRowsInColumn: %d is too high; count is %d", column, columnCount);
			return 0;
		}
	}
	if (column == 0) {
		if (columnCount > 0) ret = 1;
		else ret = 0;
	} else {
		ret = [[[browserPath objectAtIndex:(column - 1)] subviews] count];
	}
	return ret;
}

- (IBAction)browserSelectionChanged:(id)sender
{
	NSView *selectedView = nil;
	NSRect selectedFrame;
	NSRect windowFrame;
	NSRect showFrame;
	int lastColumn = [sender selectedColumn];
	int row = [sender selectedRowInColumn:lastColumn];
	if (row < 0) {
		lastColumn--;
		row = [sender selectedRowInColumn:lastColumn];
	}
	[self browser:sender selectRow:row inColumn:lastColumn];
	selectedView = [browserPath lastObject];
	[viewClassField setStringValue:[selectedView className]];
	selectedFrame = [selectedView convertRect:[selectedView bounds] toView:nil];
	[windowPositionField setStringValue:[NSString stringWithFormat:@"(%f, %f)",
										 selectedFrame.origin.x, selectedFrame.origin.y]];
	[sizeField setStringValue:[NSString stringWithFormat:@"%f x %f",
							   selectedFrame.size.width, selectedFrame.size.height]];
	windowFrame = [viewedWindow frame];
	showFrame = NSMakeRect(windowFrame.origin.x + selectedFrame.origin.x,
						   windowFrame.origin.y + selectedFrame.origin.y,
						   selectedFrame.size.width, selectedFrame.size.height);
	[highlightWindow setFrame:showFrame display:YES];
	[highlightWindow orderFront:self];
}

@end

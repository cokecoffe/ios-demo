#import <Cocoa/Cocoa.h>


@interface MYViewFinderController : NSObject
{
	IBOutlet NSBrowser *browser;
	IBOutlet NSTextField *viewClassField;
	IBOutlet NSTextField *windowPositionField;
	IBOutlet NSTextField *sizeField;
	NSWindow *viewedWindow;
	NSMutableArray *browserPath;
	NSWindow *highlightWindow;
}

- (void)mainWindowChanged:(id)sender;
- (IBAction)browserSelectionChanged:(id)sender;

@end

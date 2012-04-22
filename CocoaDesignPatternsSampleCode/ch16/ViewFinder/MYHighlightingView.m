#import "MYHighlightingView.h"


@implementation MYHighlightingView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
	if (!self) return nil;
	// Initialization code here.
    return self;
}

- (void)drawRect:(NSRect)rect
{
	NSRect myBounds = [self bounds];
//	NSLog(@"Drawing highlight ((%f, %f), (%f, %f))", myBounds.origin.x, myBounds.origin.y, myBounds.size.height, myBounds.size.width);
	[[[NSColor redColor] colorWithAlphaComponent:0.5] set];
	NSFrameRectWithWidthUsingOperation(myBounds, 2.0, NSCompositeSourceOver);
}

- (BOOL)isOpaque
{
	return NO;
}

@end

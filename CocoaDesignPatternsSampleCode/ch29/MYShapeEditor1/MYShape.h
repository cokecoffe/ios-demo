#import <Cocoa/Cocoa.h>


@interface MYShape : NSObject <NSCoding>
{
   NSRect        frame;
   NSColor       *color;
}

@property (readwrite, assign) CGFloat positionX;
@property (readwrite, assign) CGFloat positionY;
@property (readwrite, copy) NSColor *color;

// Returns the receiver's frame
- (NSRect)frame;

// Moves the receiver's frame by the specified amounts
- (void)moveByDeltaX:(float)deltaX deltaY:(float)deltaY;

// This is a Template Method to customize selection logic.  The default
// implementation returns YES if aPoint is within frame.  Override this
// method to be more selective.  The default implementation can be
// called from overridden versions.
- (BOOL)doesContainPoint:(NSPoint)aPoint;

@end

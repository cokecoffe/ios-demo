#import "MYShapeView.h"
#import "MYShape.h"


// Declare an informal protocol that MYShape instances must implement 
// in order to be displayed in a MYShapeView.
@interface MYShape (MYShapeQuartzDrawing)

// This is a Template Method to customize drawing.  The default
// implementation fills the receiver’s frame with the receiver’s color.
// Override this method to customize drawing.  The default 
// implementation can be called from overridden versions, but it is
// not necessary to call the default version.
- (void)drawInRect:(NSRect)aRect;

@end


@implementation MYShapeView

@synthesize dataSource;


- (void)dealloc
{
   [self setDataSource:nil];
   [super dealloc];
}


// Draw all of the MYShape instances provided by the dataSource from back to
// front
- (void)drawRect:(NSRect)aRect 
{
    [[NSColor whiteColor] set];
    NSRectFill(aRect);
    
    MYShape      *currentShape = nil;
    for(currentShape in [[self dataSource] shapesInOrderBackToFront])
    {
       [currentShape drawInRect:aRect];
    }
}

@end


@implementation MYShape (MYShapeQuartzDrawing)

// Draw the receiver in the current Quartz graphics context
- (void)drawInRect:(NSRect)aRect
{
   if(NSIntersectsRect(aRect, [self frame]))
   {
      [[self color] set];
      NSRectFill([self frame]);
   }
}

@end


@implementation NSObject (MYShapeViewDataSource)

- (NSArray *)shapesInOrderBackToFront
{
   return [NSArray array];
}

@end

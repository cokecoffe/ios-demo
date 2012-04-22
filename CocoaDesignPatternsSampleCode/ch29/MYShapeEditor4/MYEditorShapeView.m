#import "MYEditorShapeView.h"
#import "MYShape.h"


// Constant used for drawing selection indication
static const float MYSelectionIndicatorWidth = 6.0f;

// Declare the dragStartPoint property within an unnamed category
// inside the class implementation so that the property is not part of 
// the public interface
@interface MYEditorShapeView ()

@property (readwrite, assign) NSPoint dragStartPoint;

@end


@implementation MYEditorShapeView

@synthesize dragStartPoint;

- (void)setDataSource:(id)anObject
{
   [dataSource removeObserver:self forKeyPath:@"selectedObjects"];
   
   [super setDataSource:anObject];
   
   [dataSource addObserver:self forKeyPath:@"selectedObjects"
                   options:(NSKeyValueObservingOptionNew) context:NULL];
}


// Override the inherited implementation to first draw the shapes and
// then draw any selection indications
- (void)drawRect:(NSRect)aRect 
{
   [super drawRect:aRect];
   
   [NSBezierPath setDefaultLineWidth:MYSelectionIndicatorWidth];
   [[NSColor selectedControlColor] set];

   // Draw selection indication around each selected shape
   MYShape      *currentShape = nil;
   for(currentShape in [[self dataSource] selectedObjects])
   {
      [NSBezierPath strokeRect:[currentShape frame]];
   }
}


// Return the graphically top most shape that contains appoint or nil
// if no shape contains appoint.
- (NSInteger)indexOfTopMostShapeAtPoint:(NSPoint)aPoint
{
   NSInteger    result = NSNotFound;
   NSArray      *arrangedObjects = [[self dataSource] 
                                    arrangedObjects];
   NSInteger    i;
   
   for(i = [arrangedObjects count] - 1; (i >= 0) && 
       (NSNotFound == result); i--)
   {
      if([[arrangedObjects objectAtIndex:i] doesContainPoint:aPoint])
      {
         result = i;
      }
   }
   
   return result;
}


// Select or deselect shapes when the mouse button is pressed.
// Standard management for multiple selection is provided.  A mouse
// down without modifier key deselects all previously selected shapes
// and selects the shape if any under the mouse.  If the Shift modifier
// is used and there is a shape under the mouse, toggle the selection
// of the shape under the mouse without affecting the selection status
// of other shapes.
- (void)mouseDown:(NSEvent *)anEvent
{
   NSPoint    location = [self convertPoint:[anEvent locationInWindow] 
      fromView:nil];
   
   // Set the drag start location in case the event starts a drag
   // operation
   [self setDragStartPoint:location];
   
   // Find the shape if any under the mouse
   NSInteger      hitShapeIndex = [self
      indexOfTopMostShapeAtPoint:location];
   
   if(NSNotFound == hitShapeIndex)
   {  // There is no shape under the mouse
      // set selection to empty set
      [(NSArrayController *)[self dataSource] setSelectionIndexes:
         [NSIndexSet indexSet]];
   }
   else if([[[self dataSource] selectionIndexes]
            containsIndex:hitShapeIndex])
   {  // The shape under the mouse is already selected
      
      if(0 != (NSShiftKeyMask & [anEvent modifierFlags]))
      { // Remove the shape under the mouse from the selection
         [[self dataSource] removeSelectionIndexes:
            [NSIndexSet indexSetWithIndex:hitShapeIndex]];
      } 
   }
   else
   {  // The shape under the mouse is not already selected
      
      if(0 != (NSShiftKeyMask & [anEvent modifierFlags]))
      { // Add the shape under the mouse to the selection
         [[self dataSource] addSelectionIndexes:
            [NSIndexSet indexSetWithIndex:hitShapeIndex]];
      }
      else
      {  // Make the shape under the mouse to only selection
         [(NSArrayController *)[self dataSource] setSelectionIndexes:
            [NSIndexSet indexSetWithIndex:hitShapeIndex]];
      }
   }
}


// Drag any selected shapes
- (void)mouseDragged:(NSEvent *)anEvent
{
   [[self dataSource] objectDidBeginEditing:self];
   NSPoint      location = [self convertPoint:
                            [anEvent locationInWindow] fromView:nil];
   
   NSPoint      startPoint = [self dragStartPoint];
   float        deltaX = location.x - startPoint.x;
   float        deltaY = location.y - startPoint.y;
   
   MYShape      *currentShape = nil;
   for(currentShape in [[self dataSource] selectedObjects])
   {
      [currentShape moveByDeltaX:deltaX deltaY:deltaY];
   }
   
   [self setDragStartPoint:location];
   [self autoscroll:anEvent];  // scroll to keep shapes in view
   
   [[self dataSource] objectDidEndEditing:self];
}

@end

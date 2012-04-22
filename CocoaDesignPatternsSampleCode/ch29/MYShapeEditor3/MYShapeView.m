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

@dynamic dataSource;


- (void)dealloc
{
   [self setDataSource:nil];
   [super dealloc];
}


- (id)dataSource
{
   return [[dataSource retain] autorelease];
}


- (void)setDataSource:(id)anObject
{
   [dataSource removeObserver:self forKeyPath:@"arrangedObjects"];
   [dataSource removeObserver:self forKeyPath:@"arrangedObjects.frame"];
   [dataSource removeObserver:self forKeyPath:@"arrangedObjects.color"];

   [anObject retain];
   [dataSource release];
   dataSource = anObject;

   [dataSource addObserver:self forKeyPath:@"arrangedObjects"
                   options:(NSKeyValueObservingOptionNew) context:NULL];
   [dataSource addObserver:self forKeyPath:@"arrangedObjects.frame"
                   options:(NSKeyValueObservingOptionNew) context:NULL];
   [dataSource addObserver:self forKeyPath:@"arrangedObjects.color"
                   options:(NSKeyValueObservingOptionNew) context:NULL];
}


// Draw all of the MYShape instances provided by the dataSource from back to
// front
- (void)drawRect:(NSRect)aRect 
{
    [[NSColor whiteColor] set];
    NSRectFill(aRect);
    
    MYShape      *currentShape = nil;
    for(currentShape in [[self dataSource] arrangedObjects])
    {
       [currentShape drawInRect:aRect];
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath
   ofObject:(id)object
   change:(NSDictionary *)change
   context:(void *)context
{
   [self setNeedsDisplay:YES];
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

- (NSArray *)arrangedObjects
{
   return [NSArray array];
}

@end

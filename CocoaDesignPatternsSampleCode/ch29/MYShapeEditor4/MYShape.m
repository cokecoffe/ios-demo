#import "MYShape.h"


@interface MYShape (MYPrivate)

- (void)setFrame:(NSRect)aFrame;

@end


@implementation MYShape

@synthesize color;


+ (NSSet *)keyPathsForValuesAffectingPositionX
{
   return [NSSet setWithObjects:@"frame", nil];
}


+ (NSSet *)keyPathsForValuesAffectingPositionY
{
   return [NSSet setWithObjects:@"frame", nil];
}


- (void)dealloc
{
   [self setColor:nil];
   [super dealloc];
}


// Designated initializer
- (id)init
{
   if(nil != (self = [super init]))
   {
      [self setFrame:NSMakeRect(random() % 600, random() % 600, 72.0f, 72.0f)];
      [self setColor:[NSColor 
         colorWithCalibratedRed:((random() % 256) / 255.0f) 
         green:((random() % 256) / 255.0f) 
         blue:((random() % 256) / 255.0f)
         alpha:(1.0f)]];
   }
   
   return self;
}


// NSCoding methods
- (id)initWithCoder:(NSCoder *)aCoder
{
   if(nil != (self = [super init]))
   {
      [self setFrame:[aCoder decodeRectForKey:@"frame"]];
      [self setColor:[aCoder decodeObjectForKey:@"color"]];
   }
   
   return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
   [aCoder encodeRect:[self frame] forKey:@"frame"];
   [aCoder encodeObject:[self color] forKey:@"color"];
}


// Accessors
- (CGFloat)positionX
{
   return NSMidX([self frame]);
}


- (void)setPositionX:(float)aValue
{
   CGFloat     currentPositionX = [self positionX];
   
   [self moveByDeltaX:(aValue - currentPositionX) deltaY:(0.0f)];
}


- (CGFloat)positionY
{
   return NSMidY([self frame]);
}


- (void)setPositionY:(float)aValue
{
   CGFloat     currentPositionY = [self positionY];
   
   [self moveByDeltaX:(0.0f) deltaY:(aValue - currentPositionY)];
}


- (NSRect)frame
{
   return frame;
}


// Template Methods
- (BOOL)doesContainPoint:(NSPoint)aPoint
{
   return NSPointInRect(aPoint, [self frame]);
}


// Positioning
- (void)moveByDeltaX:(float)deltaX deltaY:(float)deltaY
{
   [self setFrame:NSMakeRect([self frame].origin.x + deltaX,
                             [self frame].origin.y + deltaY, 
                             [self frame].size.width,
                             [self frame].size.height)];
}

@end


@implementation MYShape (MYPrivate)

// Accessor
- (void)setFrame:(NSRect)aFrame
{
   frame = aFrame;
}

@end



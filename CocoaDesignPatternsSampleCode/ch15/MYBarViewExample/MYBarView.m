#import "MYBarView.h"

//! Informal protocol defined messages sent from MYBarView to its delegate
@interface NSObject (MYBarViewDelegateSupport)

- (float)barView:(id)barView shouldChangeValue:(float)newValue;
- (void)barViewWillChangeValue:(NSNotification *)aNotification;
- (void)barViewDidChangeValue:(NSNotification *)aNotification;

@end

@implementation MYBarView

- (id)initWithFrame:(NSRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self setBarColor:[NSColor grayColor]];
    }
    return self;
}

- (float)_myBarShouldChangeValue:(float)newValue
/*! Give the delegate a chance to change the new value */
{
   if([[self delegate] respondsToSelector:
       @selector(barView:shouldChangeValue:)])
   {
      newValue = [[self delegate] barView:self
                        shouldChangeValue:newValue];
   }
   
   return newValue;
}

- (void)_myBarWillChangeValue
/*! Notify the delegate and default notification center that the value
 is about to change.*/
{
   NSNotification     *notification;
   
   notification = [NSNotification notificationWithName:
                   MYBarViewWillChangeValueNotification object:self];
   
   if([[self delegate] respondsToSelector:
       @selector(barViewWillChangeValue:)])
   {
      [[self delegate] barViewWillChangeValue:notification];
   }
   [[NSNotificationCenter defaultCenter]
    postNotification:notification];
}

- (void)_myBarDidChangeValue
/*! Notify the delegate and default notification center that the value 
 just changed. */
{
   NSNotification     *notification;
   
   notification = [NSNotification notificationWithName:
                  MYBarViewDidChangeValueNotification object:self];
   
   if([[self delegate] respondsToSelector:
       @selector(barViewDidChangeValue:)])
   {
      [[self delegate] barViewDidChangeValue:notification];
   }
   [[NSNotificationCenter defaultCenter] 
    postNotification:notification];
}

//! Accessors
- (float)barValue
//! Returns the receiver's value
{
   return barValue;
}

- (void)setBarValue:(float)aValue
//! Sets the receiver's value
{
   barValue = aValue;
   [self setNeedsDisplay:YES];
}

- (NSColor *)barColor
//! Returns the receiver's color
{
   return barColor;
}

- (void)setBarColor:(NSColor *)aColor
//! Sets the receiver's color
{
   [aColor retain];
   [barColor release];
   barColor = aColor;
   [self setNeedsDisplay:YES];
}

- (id)delegate
//! Returns the receiver's delegate
{
   return delegate;
}

- (void)setDelegate:(id)anObject
//! Sets the receiver's delegate
{
   delegate = anObject;  // Note: not retained!
}

//! Actions
- (IBAction)takeBarValueFrom:(id)sender
/*! Sets the receiver's value to sender's floatValue.  The receiver's delegate 
 is given an opportunity to change the new value before it is set and is 
 notified of the change before and after the value is set. */ 
{
   float newValue = [sender floatValue];
   
   newValue = [self _myBarShouldChangeValue:newValue];
   [self _myBarWillChangeValue];
   [self setBarValue:newValue];
   [self _myBarDidChangeValue];
}


- (void)drawRect:(NSRect)rect 
{
   NSRect     areaToFill = [self bounds];
   
   [[NSColor whiteColor] set];
   NSRectFill([self bounds]);
   [[self barColor] set];
   areaToFill.size.width *= [self barValue];
   NSRectFill(areaToFill);
}

@end

//! Notification names
NSString  *MYBarViewDidChangeValueNotification = 
   @"MYBarViewDidChangeValueNotification";
NSString  *MYBarViewWillChangeValueNotification =
   @"MYBarViewWillChangeValueNotification";

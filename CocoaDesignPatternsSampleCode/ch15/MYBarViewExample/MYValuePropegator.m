#import "MYValuePropegator.h"
#import "MYBarView.h"


@implementation MYValuePropegator

//! Let the Objective C 2.0 compiler generate the accessor code
@synthesize barViewToControl;

- (void)barViewDidChangeValue:(NSNotification *)aNotification
{
   if([aNotification object] != [self barViewToControl])
   {
      [[self barViewToControl] setBarValue:[[aNotification object] barValue]];
   }
}

@end

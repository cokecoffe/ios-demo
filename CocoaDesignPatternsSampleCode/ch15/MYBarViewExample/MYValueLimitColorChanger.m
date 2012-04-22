#import "MYValueLimitColorChanger.h"
#import "MYBarView.h"


@implementation MYValueLimitColorChanger

//! Delegate messages
- (float)barView:(id)barView shouldChangeValue:(float)newValue
{
   float      result = newValue;
   
   if(0.25f > result)
   {
      result = 0.25f;
   }
   
   return result;
}


- (void)barViewDidChangeValue:(NSNotification *)aNotification
{
   if(0.75f < [[aNotification object] barValue])
   {
      [[aNotification object] setBarColor:[NSColor blackColor]];
   }
   else
   {
      [[aNotification object] setBarColor:[NSColor grayColor]];
   }
}

@end

#import <Cocoa/Cocoa.h>

@class MYBarView;

@interface MYValuePropegator : NSObject 
{
   IBOutlet MYBarView *barViewToControl;    //! The object to control
}

//! Declare accessor as Objective C 2.0 @property
@property (readwrite, retain, nonatomic) IBOutlet MYBarView *barViewToControl;

@end

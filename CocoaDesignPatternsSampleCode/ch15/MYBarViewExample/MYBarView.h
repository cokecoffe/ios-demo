#import <Cocoa/Cocoa.h>


@interface MYBarView : NSView 
{
   IBOutlet id delegate;    //! The delegate if any
   NSColor     *barColor;   //! The color of the bar
   float       barValue;    //! The value (0.0 to 1.0) to indicate
}

@property (assign, nonatomic, readwrite) IBOutlet id delegate;
@property (retain, nonatomic, readwrite) NSColor *barColor;
@property (nonatomic, readwrite) float barValue;
 
//! Accessors
- (id)delegate;
- (void)setDelegate:(id)anObject;
- (float)barValue;
- (void)setBarValue:(float)aValue;
- (NSColor *)barColor;
- (void)setBarColor:(NSColor *)aColor;

//! Actions 
- (IBAction)takeBarValueFrom:(id)sender;

@end

//! Notification names
extern NSString  *MYBarViewDidChangeValueNotification;
extern NSString  *MYBarViewWillChangeValueNotification;

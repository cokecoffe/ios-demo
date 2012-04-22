#import <Cocoa/Cocoa.h>


@interface JunctionAppController : NSObject
{
	NSMutableArray *windowControllers;
}

- (IBAction)openAllWindows:(id)sender;

@end

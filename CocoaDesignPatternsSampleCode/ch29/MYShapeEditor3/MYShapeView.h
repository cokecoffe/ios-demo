#import <Cocoa/Cocoa.h>


@interface MYShapeView : NSView 
{
   IBOutlet id        dataSource;
}

@property (readwrite, retain) id dataSource;

@end


@interface NSObject (MYShapeViewDataSource)

- (NSArray *)arrangedObjects;

@end

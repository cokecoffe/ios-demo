#import <Cocoa/Cocoa.h>

@class MYMediatingController;


@interface MYShapeEditorDocument : NSDocument
{
   NSArray              *shapesInOrderBackToFront; // The Model
   IBOutlet NSView      *shapeGraphicView;    
   IBOutlet NSTableView *shapeTableView;    
   IBOutlet MYMediatingController *mediatingController;    
}

@property (readonly, copy) NSArray *shapesInOrderBackToFront;
@property (readwrite, retain) NSView *shapeGraphicView;
@property (readwrite, retain) NSTableView *shapeTableView;
@property (readwrite, retain) MYMediatingController *mediatingController;

- (void)mediatingControllerDidDetectChange:(NSNotification *)aNotification;

@end

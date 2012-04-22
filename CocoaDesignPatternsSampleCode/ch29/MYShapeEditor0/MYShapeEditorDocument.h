#import <Cocoa/Cocoa.h>

@interface MYShapeEditorDocument : NSDocument
{
   NSArray              *shapesInOrderBackToFront; // Storage for the Model
   IBOutlet NSView      *shapeGraphicView;    
   IBOutlet NSTableView *shapeTableView;    
}

@property (readonly, copy) NSArray *shapesInOrderBackToFront;
@property (readwrite, retain) NSView *shapeGraphicView;
@property (readwrite, retain) NSTableView *shapeTableView;

@end


@interface NSObject (MYShapeEditorDocumentEditing)

- (void)controllerDidBeginEditing;
- (void)controllerDidEndEditing;

@end

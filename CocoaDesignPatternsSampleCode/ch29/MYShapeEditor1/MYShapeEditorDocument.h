#import <Cocoa/Cocoa.h>

@interface MYShapeEditorDocument : NSDocument
{
   NSArray              *shapesInOrderBackToFront; // The Model
   IBOutlet NSView      *shapeGraphicView;    
   IBOutlet NSTableView *shapeTableView;    
   NSIndexSet           *selectionIndexes;         // The selection   
}

@property (readonly, copy) NSArray *shapesInOrderBackToFront;
@property (readwrite, retain) NSView *shapeGraphicView;
@property (readwrite, retain) NSTableView *shapeTableView;

// Actions
- (IBAction)addShape:(id)sender;
- (IBAction)removeSelectedShapes:(id)sender;

// Selection Management
- (BOOL)setControllerSelectionIndexes:(NSIndexSet *)indexes;
- (NSIndexSet *)controllerSelectionIndexes;
- (BOOL)controllerAddSelectionIndexes:(NSIndexSet *)indexes;
- (BOOL)controllerRemoveSelectionIndexes:(NSIndexSet *)indexes;
- (NSArray *)selectedObjects;

@end


@interface NSObject (MYShapeEditorDocumentEditing)

- (void)controllerDidBeginEditing;
- (void)controllerDidEndEditing;

@end

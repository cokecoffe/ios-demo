#import <Cocoa/Cocoa.h>

@class MYMediatingController;


@interface MYShapeEditorDocument : NSDocument
{
   NSArray              *shapesInOrderBackToFront; // The Model
}

@property (readonly, copy) NSArray *shapesInOrderBackToFront;

@end

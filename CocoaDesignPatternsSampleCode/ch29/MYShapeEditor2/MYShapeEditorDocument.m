#import "MYShapeEditorDocument.h"
#import "MYShape.h"
#import "MYMediatingController.h"

@interface MYShapeEditorDocument ()

@property (readwrite, copy) NSArray *shapesInOrderBackToFront;

@end


@implementation MYShapeEditorDocument

@synthesize shapesInOrderBackToFront;
@synthesize shapeGraphicView;
@synthesize shapeTableView;
@synthesize mediatingController;


- (void)dealloc
{
   [self setShapesInOrderBackToFront:nil];
   [super dealloc];
}


- (void)mediatingControllerDidDetectChange:(NSNotification *)aNotification;
{
   [[self shapeGraphicView] setNeedsDisplay:YES];    
   [[self shapeTableView] reloadData];    
   [[self shapeTableView] selectRowIndexes:
      [[self mediatingController] controllerSelectionIndexes] 
      byExtendingSelection:NO];
}


// Coordination methods
- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
   [super windowControllerDidLoadNib:aController];
   
   if(nil == [self shapesInOrderBackToFront])
   {
      [self setShapesInOrderBackToFront:[NSArray array]];
   }
   
   if(nil != [self mediatingController])
   {
      [[NSNotificationCenter defaultCenter] addObserver:self 
         selector:@selector(mediatingControllerDidDetectChange:)
         name:MYMediatingControllerContentDidChange
         object:[self mediatingController]];
   
      [[self mediatingController] controllerDidBeginEditing];
      [[self mediatingController] setContentProvider:self];
      [[self mediatingController] setContentProviderKey:@"shapesInOrderBackToFront"];
      [[self mediatingController] setObjectClass:[MYShape class]];
      [[self mediatingController] controllerDidEndEditing];
   }
}


- (NSString *)windowNibName
{
   return @"MYShapeEditorDocument";
}


- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
   NSData    *result = [NSKeyedArchiver archivedDataWithRootObject:
      [self shapesInOrderBackToFront]];
   
   if ((nil == result) && (NULL != outError)) 
   {  // Report failure to archive the Model data
      *outError = [NSError errorWithDomain:NSOSStatusErrorDomain
                                      code:unimpErr userInfo:NULL];
   }
   
   return result;
}


- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName
               error:(NSError **)outError
{
   NSArray    *loadedShapes = [NSKeyedUnarchiver
                                      unarchiveObjectWithData:data];
   
   if(nil != loadedShapes)
   {
      [self setShapesInOrderBackToFront:loadedShapes];
   }    
   else if ( NULL != outError) 
   {  // Report failure to unarchive the model from provided data
      *outError = [NSError errorWithDomain:NSOSStatusErrorDomain
                                      code:unimpErr userInfo:NULL];
   }
   
   return YES;
}

@end

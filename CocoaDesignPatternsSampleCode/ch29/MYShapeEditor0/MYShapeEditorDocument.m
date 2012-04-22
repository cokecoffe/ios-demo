#import "MYShapeEditorDocument.h"
#import "MYShape.h"

@interface MYShapeEditorDocument ()

@property (readwrite, copy) NSArray *shapesInOrderBackToFront;

@end


@implementation MYShapeEditorDocument

@synthesize shapesInOrderBackToFront;
@synthesize shapeGraphicView;
@synthesize shapeTableView;


- (void)dealloc
{
   [self setShapesInOrderBackToFront:nil];
   [super dealloc];
}


// Editing
- (void)controllerDidEndEditing
{
   [[self shapeGraphicView] setNeedsDisplay:YES];    
   [[self shapeTableView] reloadData];    
}


// NSTableView data source methods
- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
   return [[self shapesInOrderBackToFront] count];
}


- (id)tableView:(NSTableView *)aTableView
   objectValueForTableColumn:(NSTableColumn *)aTableColumn
   row:(int)rowIndex
{
   id shape = [[self shapesInOrderBackToFront] objectAtIndex:rowIndex];
   
   return [shape valueForKey:[aTableColumn identifier]];
}


- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject 
   forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
   [self controllerDidBeginEditing];
   id shape = [[self shapesInOrderBackToFront] objectAtIndex:rowIndex];
   
   [shape setValue:anObject forKey:[aTableColumn identifier]];
   
   [self controllerDidEndEditing];
}


// Coordination methods
- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
   [super windowControllerDidLoadNib:aController];
   
   if(nil == [self shapesInOrderBackToFront])
   {
      [self setShapesInOrderBackToFront:[NSArray array]];
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
   else if(NULL != outError) 
   {  // Report failure to unarchive the model from provided data
      *outError = [NSError errorWithDomain:NSOSStatusErrorDomain
                                      code:unimpErr userInfo:NULL];
   }
   
   return YES;
}

@end


@implementation NSObject (MYShapeEditorDocumentEditing)

// Editing
- (void)controllerDidBeginEditing
{
}


- (void)controllerDidEndEditing
{
}

@end

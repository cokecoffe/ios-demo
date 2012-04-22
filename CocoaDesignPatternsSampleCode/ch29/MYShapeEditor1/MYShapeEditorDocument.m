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
   [self setControllerSelectionIndexes:nil];
   [super dealloc];
}


// Actions
- (IBAction)addShape:(id)sender;
{
   [self controllerDidBeginEditing];
   [self setShapesInOrderBackToFront:[shapesInOrderBackToFront 
      arrayByAddingObject:[[[MYShape alloc] init] autorelease]]];
      
   [self controllerDidEndEditing];
}


- (IBAction)removeSelectedShapes:(id)sender;
{
   [self controllerDidBeginEditing];
   NSRange    allShapesRange = NSMakeRange(0, 
      [[self shapesInOrderBackToFront] count]);
   NSMutableIndexSet  *indexesToKeep = [NSMutableIndexSet 
      indexSetWithIndexesInRange:allShapesRange];
      
   [indexesToKeep removeIndexes:[self controllerSelectionIndexes]];
   [self setShapesInOrderBackToFront:[[self shapesInOrderBackToFront] 
      objectsAtIndexes:indexesToKeep]];
   [self setControllerSelectionIndexes:[NSIndexSet indexSet]];

   [self controllerDidEndEditing];
}


// Selection Management
- (BOOL)setControllerSelectionIndexes:(NSIndexSet *)indexes
{
   [self controllerDidBeginEditing];
   [indexes retain];
   [selectionIndexes release];
   selectionIndexes = indexes;
   
   [self controllerDidEndEditing];
   
   return YES;
}


- (NSIndexSet *)controllerSelectionIndexes
{
   if(nil == selectionIndexes)
   {  // Set initially empty selection
      [self setControllerSelectionIndexes:[NSIndexSet indexSet]];
   }
   
   return selectionIndexes;
}


- (BOOL)controllerAddSelectionIndexes:(NSIndexSet *)indexes
{
   NSMutableIndexSet  *newIndexSet = 
      [[self controllerSelectionIndexes] mutableCopy];
   
   [newIndexSet addIndexes:indexes];
   [self setControllerSelectionIndexes:newIndexSet];
   
   return YES;
}


- (BOOL)controllerRemoveSelectionIndexes:(NSIndexSet *)indexes
{
   NSMutableIndexSet  *newIndexSet = 
      [[self controllerSelectionIndexes] mutableCopy];
   
   [newIndexSet removeIndexes:indexes];
   [self setControllerSelectionIndexes:newIndexSet];

   return YES;
}


- (NSArray *)selectedObjects
{
   return [[self shapesInOrderBackToFront] objectsAtIndexes:
      [self controllerSelectionIndexes]];
}


// Editing
- (void)controllerDidEndEditing
{
   [[self shapeGraphicView] setNeedsDisplay:YES];    
   [[self shapeTableView] reloadData];    
   [[self shapeTableView] selectRowIndexes:[self controllerSelectionIndexes] 
                      byExtendingSelection:NO];
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
   id shape = [[self shapesInOrderBackToFront]
               objectAtIndex:rowIndex];
   
   [shape setValue:anObject forKey:[aTableColumn identifier]];
   
   [self controllerDidEndEditing];
}


// NSTableView delegate methods
- (NSIndexSet *)tableView:(NSTableView *)tableView 
   selectionIndexesForProposedSelection:
   (NSIndexSet *)proposedSelectionIndexes
{
   [self setControllerSelectionIndexes:proposedSelectionIndexes];
   
   return proposedSelectionIndexes;
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
   else if ( NULL != outError) 
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

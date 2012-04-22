#import "MYMediatingController.h"


@implementation MYMediatingController

@synthesize objectClass;
@synthesize contentProvider;
@synthesize contentProviderKey;

- (void)dealloc
{
   [self controllerSetSelectionIndexes:nil];
   [self setContentProvider:nil];
   [self setContentProviderKey:nil];
   [super dealloc];
}


// arranged content
- (NSArray *)arrangedObjects
{
   return [[self contentProvider] valueForKey:
           [self contentProviderKey]];
}


// Actions
- (IBAction)add:(id)sender;
{
   [self controllerDidBeginEditing];
   NSArray  *newContent = [[self arrangedObjects] arrayByAddingObject:
      [[[[self objectClass] alloc] init] autorelease]];
   
   [[self contentProvider] setValue:newContent forKey:
      [self contentProviderKey]];
   
   [self controllerDidEndEditing];
}


- (IBAction)remove:(id)sender;
{
   [self controllerDidBeginEditing];
   NSRange    allObjectsRange = NSMakeRange(0, 
      [[self arrangedObjects] count]);
   NSMutableIndexSet  *indexesToKeep = [NSMutableIndexSet 
      indexSetWithIndexesInRange:allObjectsRange];
   
   [indexesToKeep removeIndexes:[self controllerSelectionIndexes]];
   NSArray  *newContent = [[self arrangedObjects] 
                           objectsAtIndexes:indexesToKeep];
   
   [[self contentProvider] setValue:newContent forKey:
      [self contentProviderKey]];
   
   [self controllerSetSelectionIndexes:[NSIndexSet indexSet]];
   
   [self controllerDidEndEditing];
}


// Selection Management
- (BOOL)controllerSetSelectionIndexes:(NSIndexSet *)indexes
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
   {
      // Set initially empty selection
      [self controllerSetSelectionIndexes:[NSIndexSet indexSet]];
   }
   
   return selectionIndexes;
}


- (BOOL)controllerAddSelectionIndexes:(NSIndexSet *)indexes
{
   NSMutableIndexSet  *newIndexSet = 
   [[self controllerSelectionIndexes] mutableCopy];
   
   [newIndexSet addIndexes:indexes];
   [self controllerSetSelectionIndexes:newIndexSet];
   
   return YES;
}


- (BOOL)controllerRemoveSelectionIndexes:(NSIndexSet *)indexes
{
   NSMutableIndexSet  *newIndexSet = 
   [[self controllerSelectionIndexes] mutableCopy];
   
   [newIndexSet removeIndexes:indexes];
   [self controllerSetSelectionIndexes:newIndexSet];
   
   return YES;
}


- (NSArray *)selectedObjects;
{
   return [[self arrangedObjects] objectsAtIndexes:
      [self controllerSelectionIndexes]];
}


// Editing
- (void)controllerDidEndEditing
{
   [[NSNotificationCenter defaultCenter]
      postNotificationName:MYMediatingControllerContentDidChange 
      object:self];
}


// NSTableView data source methods
- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
   return [[self arrangedObjects] count];
}


- (id)tableView:(NSTableView *)aTableView
   objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
   id shape = [[self arrangedObjects] objectAtIndex:rowIndex];
   
   return [shape valueForKey:[aTableColumn identifier]];
}


- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject 
   forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
   [self controllerDidBeginEditing];
   id shape = [[self arrangedObjects] objectAtIndex:rowIndex];
   
   [shape setValue:anObject forKey:[aTableColumn identifier]];
   
   [self controllerDidEndEditing];
}


// NSTableView delegate methods
- (NSIndexSet *)tableView:(NSTableView *)tableView 
   selectionIndexesForProposedSelection:
   (NSIndexSet *)proposedSelectionIndexes
{
   [self controllerSetSelectionIndexes:proposedSelectionIndexes];
   
   return proposedSelectionIndexes;
}

@end


@implementation NSObject (MYMediatingController)

// Editing
- (void)controllerDidBeginEditing
{
}

- (void)controllerDidEndEditing
{
}

@end



NSString *MYMediatingControllerContentDidChange = 
   @"MYMediatingControllerContentDidChange";

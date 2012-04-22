#import "MYShapeEditorDocument.h"
#import "MYShape.h"

@interface MYShapeEditorDocument ()

@property (readwrite, copy) NSArray *shapesInOrderBackToFront;

@end


@implementation MYShapeEditorDocument

@synthesize shapesInOrderBackToFront;


- (void)dealloc
{
   [self setShapesInOrderBackToFront:nil];
   [super dealloc];
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

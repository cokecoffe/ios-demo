#import <Cocoa/Cocoa.h>


@interface MYMediatingController : NSObject 
{
   Class                objectClass;         // Class of Model objects
   IBOutlet id          contentProvider;     // Provider of Model array
   NSString             *contentProviderKey; // The array property name
   NSIndexSet           *selectionIndexes;   // selection   
}

@property (readwrite, assign) Class objectClass;
@property (readwrite, retain) id contentProvider;
@property (readwrite, copy) NSString *contentProviderKey;

// arranged content
- (NSArray *)arrangedObjects;

// Actions
- (IBAction)add:(id)sender;
- (IBAction)remove:(id)sender;

// Selection Management
- (BOOL)controllerSetSelectionIndexes:(NSIndexSet *)indexes;
- (NSIndexSet *)controllerSelectionIndexes;
- (BOOL)controllerAddSelectionIndexes:(NSIndexSet *)indexes;
- (BOOL)controllerRemoveSelectionIndexes:(NSIndexSet *)indexes;
- (NSArray *)selectedObjects;

@end

@interface NSObject (MYMediatingController)

- (void)controllerDidBeginEditing;
- (void)controllerDidEndEditing;

@end

extern NSString *MYMediatingControllerContentDidChange;

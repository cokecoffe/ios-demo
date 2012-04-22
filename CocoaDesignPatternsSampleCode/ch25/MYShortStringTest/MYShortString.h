#import <Foundation/Foundation.h>

#define _MYMAX_SHORT_STRING_LENGTH (40)

@interface MYShortString : NSString
{
   // storage for the short string
   unichar         _myBuffer[_MYMAX_SHORT_STRING_LENGTH+1];
   
   // number of unichars not counting null termination 
   NSUInteger      _myLength;             
}

// Overridden allocator
+ (id)allocWithZone:(NSZone *)aZone;

// Shared resource cleanup
+ (void)cleanup;

// Reuse statistics
+ (NSUInteger)numberOfAvailableInstances;
+ (NSUInteger)totalNumberOfInstances;

// Overridden designated initializer
- (id)init;

// Other initializers
- (id)initWithCharacters:(const unichar *)characters
                  length:(NSUInteger)length;
- (id)initWithUTF8String:(const char *)nullTerminatedCString;
- (id)initWithString:(NSString *)aString;
- (id)initWithFormat:(NSString *)format, ...;
- (id)initWithFormat:(NSString *)format arguments:(va_list)argList;
- (id)initWithFormat:(NSString *)format locale:(id)locale, ...;
- (id)initWithFormat:(NSString *)format locale:(id)locale
           arguments:(va_list)argList;
- (id)initWithCString:(const char *)bytes length:(NSUInteger)length;
- (id)initWithCString:(const char *)bytes;	

// NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

// NSCopying
- (id)copyWithZone:(NSZone *)aZone;

// NSMutableCopying
- (id)mutableCopyWithZone:(NSZone *)aZone;

// Overridden NSString primitive methods
- (NSUInteger)length;
- (unichar)characterAtIndex:(NSUInteger)index;

// Overridden NSString performance methods
- (void)getCharacters:(unichar *)buffer;
- (void)getCharacters:(unichar *)buffer range:(NSRange)aRange;

@end

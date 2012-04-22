#import "MYShortString.h"


@implementation MYShortString

#define _MYMaxNumberOfCachedInstance (10000)

// Collection of shared instances
static MYShortString
   *_MYShortStringCache[_MYMaxNumberOfCachedInstance];

// Number of instances currently available for reuse
static NSUInteger       _MYAvailableInstances = 0;

// Number of instances currently allocated
static NSUInteger       _MYTotalNumberOfInstances = 0;

// Used to disable caching during cache cleanup
static BOOL             _MYCacheIsDisabled = NO;


+ (void)cleanup;
// Releases all cached short string instances
{
   _MYCacheIsDisabled = YES; // prevent re-caching when instances
                             // are released
   
   NSUInteger    i;
   for(i = 0; i < _MYAvailableInstances;  i++)
   {
      [_MYShortStringCache[i] release];
      _MYShortStringCache[i] = nil;
   }
   _MYAvailableInstances = 0;
   
   _MYCacheIsDisabled = NO;
}


+ (NSUInteger)numberOfAvailableInstances
// Returns number of MYShortString instances available for reuse.
{
   return _MYAvailableInstances;
}

+ (NSUInteger)totalNumberOfInstances
// Returns total number of MYShortString instances currently allocated.
{
   return _MYTotalNumberOfInstances;
}


// Overridden allocator
+ (id)allocWithZone:(NSZone *)aZone
{
   MYShortString		*result = nil;
   
   if(_MYAvailableInstances > 0 && aZone == NSDefaultMallocZone()) {
      // reuse available instance
      _MYAvailableInstances--;
      result = _MYShortStringCache[_MYAvailableInstances];
      _MYShortStringCache[_MYAvailableInstances] = nil;      
   } else {
      // create a new instance (Can't use +alloc here without infinite
      // recursion)
      result = NSAllocateObject([self class], 0, aZone);

      _MYTotalNumberOfInstances++;
   }
   
   return result;
}


- (void)release
// Overloaded to cache unused instances for reuse.
{
   if([self retainCount] == 1 && 
         _MYAvailableInstances < _MYMaxNumberOfCachedInstance &&
         !_MYCacheIsDisabled && 
         [self zone] == NSDefaultMallocZone()) {

      _MYShortStringCache[_MYAvailableInstances] = self;      
      _MYAvailableInstances++;
   } else {
      [super release];
   }
}

- (void)dealloc
// Clean-up
{
   _MYTotalNumberOfInstances--;
   
   [super dealloc];
}


// Overridden designated initializer
- (id)init;
{
   if(nil != (self = [super init])) {
      _myBuffer[0] = 0;
      _myLength = 0;
   }
   
   return self;
}


// Other initializers
- (id)initWithCharacters:(const unichar *)characters
                  length:(NSUInteger)length;
{
   NSParameterAssert(NULL != characters);
   
   id		result = nil;
   
   self = [self init];
   
   if(length < _MYMAX_SHORT_STRING_LENGTH) {
      memcpy(_myBuffer, characters, (length * sizeof(unichar)));
      _myLength = length;
      _myBuffer[_myLength] = 0;
      
      result = self;
   } else {
      [self release];
      self = nil;
      
      result = [[NSString alloc] initWithCharacters:characters length:length];
   }
   
   return result;
}


- (id)initWithUTF8String:(const char *)nullTerminatedCString;
{
   NSParameterAssert(NULL != nullTerminatedCString);
   
   return [self initWithCString:nullTerminatedCString 
                       encoding:NSUTF8StringEncoding];
}


- (id)initWithString:(NSString *)aString;
{
   id		        result;
   const int     length = [aString length];
   
   self = [self init];
   result = self;
   
   if(length < _MYMAX_SHORT_STRING_LENGTH) {
      NSRange		copyRange = NSMakeRange(0, length);
      
      [aString getCharacters:_myBuffer range:copyRange];
      _myBuffer[length] = '\0';
      _myLength = length;
   } else {
      [self release];
      self = nil;
      
      result = [[NSString alloc] initWithString:aString];
   }
   
   return result;
}


- (id)initWithFormat:(NSString *)format, ...;
{
   NSParameterAssert(nil != format);
   
   id          result = nil;
   va_list	   args;
   
   va_start(args, format);
   result = [self initWithFormat:format locale:nil arguments:args];
   va_end(args);
   
   return result;
}

- (id)initWithFormat:(NSString *)format arguments:(va_list)argList;
{
   NSParameterAssert(nil != format);

   return [self initWithFormat:format locale:nil arguments:argList];
}

- (id)initWithFormat:(NSString *)format locale:(id)locale, ...;
{
   NSParameterAssert(nil != format);

   id          result = nil;
   va_list	   args;
   
   va_start(args, locale);
   result = [self initWithFormat:format locale:locale arguments:args];
   va_end(args);
   
   return result;
}

- (id)initWithFormat:(NSString *)format locale:(id)locale
           arguments:(va_list)argList;
{
   NSParameterAssert(nil != format);
   
   [self release];
   self = nil;
   
   return [[NSString alloc] initWithFormat:format 
      locale:locale arguments:argList];   
}


- (id)initWithCString:(const char *)bytes length:(NSUInteger)length;
{
   NSParameterAssert(NULL != bytes);
   
   id		result = nil;
   
   //self = [self init];
   
   if(length < _MYMAX_SHORT_STRING_LENGTH) {
      int      i;
      
      for(i = 0; i < length; i++) {
         _myBuffer[i] = bytes[i];
      }
      _myLength = length;
      _myBuffer[_myLength] = 0;
      
      result = self;
   }
   else
   {
      [self release];
      self = nil;
      
      result = [[NSString alloc] initWithCString:bytes length:length];
   }
   
   return result;
}


- (id)initWithCString:(const char *)bytes;	
{
   NSParameterAssert(NULL != bytes);
   
   NSUInteger   length = strlen(bytes);
   
   return [self initWithCString:bytes length:length];
}


// NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder;
{
   [encoder encodeValueOfObjCType:@encode(NSUInteger) at:&_myLength];
   [encoder encodeArrayOfObjCType:@encode(unichar) 
      count:_myLength at:_myBuffer];
}


- (id)initWithCoder:(NSCoder *)decoder;
{
   self = [self init];
   [decoder decodeValueOfObjCType:@encode(NSUInteger) at:&_myLength];
   [decoder decodeArrayOfObjCType:@encode(unichar) 
                            count:_myLength at:_myBuffer];
                            
   return self;
}


// NSCopying
- (id)copyWithZone:(NSZone *)aZone;
{
   id     result = nil;
   
   if(aZone == [self zone]) {
      result = [self retain];
   } else {
      result = [[MYShortString allocWithZone:aZone] initWithString:self];
   }
   
   return result;
}


// NSMutableCopying
- (id)mutableCopyWithZone:(NSZone *)aZone;
{
   return [[NSMutableString allocWithZone:aZone] initWithString:self];
}


// Overridden NSString primitive methods
- (NSUInteger)length;
{
   return _myLength;
}


- (unichar)characterAtIndex:(NSUInteger)index;
{
   if(index >= _myLength) {
      [NSException raise:NSRangeException format:@""];
   }
   return _myBuffer[index];
}


// Overridden NSString performance methods
- (void)getCharacters:(unichar *)buffer;
{
   NSParameterAssert(NULL != buffer);
   
   memcpy(buffer, _myBuffer, ((_myLength) * sizeof(unichar)));
}


- (void)getCharacters:(unichar *)buffer range:(NSRange)aRange;
{
   NSParameterAssert(NULL != buffer);
   
   if((aRange.length + aRange.location) > _myLength || aRange.location < 0) {
      [NSException raise:NSRangeException format:@""];
      
   } else {
      memcpy(buffer, &_myBuffer[aRange.location], 
         (aRange.length * sizeof(unichar)));
   }
}

@end

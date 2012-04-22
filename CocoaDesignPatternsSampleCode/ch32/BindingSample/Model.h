#import <Cocoa/Cocoa.h>


@interface Model : NSObject {
   float    floatValue;
   NSColor  *color;
}

@property (readwrite) float floatValue;
@property (readwrite, retain, nonatomic) NSColor *color;

@end

#import <Cocoa/Cocoa.h>


@interface MYDirectoryChartGenerator : NSObject {

}

+ (MYDirectoryChartGenerator *)sharedGenerator;

- (NSImage *)chartForDirectory:(NSString *)directoryPath;

@end

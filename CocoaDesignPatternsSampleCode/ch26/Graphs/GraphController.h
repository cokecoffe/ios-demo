#import <Cocoa/Cocoa.h>

@class MYDirectoryChartGenerator;


@interface GraphController : NSObject {
   IBOutlet NSImageView      *imageView;
}

- (IBAction)selectAndGenerateChart:(id)sender;

@end

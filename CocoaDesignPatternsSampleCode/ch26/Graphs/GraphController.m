#import "GraphController.h"
#import "MYDirectoryChartGenerator.h"


@implementation GraphController

- (IBAction)selectAndGenerateChart:(id)sender
{
   MYDirectoryChartGenerator   *generator = [MYDirectoryChartGenerator sharedGenerator];
   
   NSImage  *resultImage = [generator chartForDirectory:NSHomeDirectory()];
   
   [imageView setImage:resultImage];
   [imageView setNeedsDisplay:YES];
}

@end

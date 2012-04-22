#import "MYDirectoryChartGenerator.h"


@implementation MYDirectoryChartGenerator

+ (MYDirectoryChartGenerator *)sharedGenerator
{
   static MYDirectoryChartGenerator *sharedInstance = nil;
   
   if(nil == sharedInstance)
   {
      sharedInstance = [[MYDirectoryChartGenerator alloc] init];
   }
   
   return sharedInstance;
}


- (NSString *)delimitedFileNamesForDirectory:(NSString *)directoryPath
{
   NSMutableString    *fileNames = [[[NSMutableString alloc] init] autorelease];
   NSString           *fileNamesCommand = [NSString stringWithFormat:@"ls %@\n",
                                           directoryPath];
   FILE               *pipe = popen([fileNamesCommand UTF8String], "r");
   int                currentChar;
   
   while(EOF != (currentChar = fgetc(pipe)))
   {
      [fileNames appendFormat:@"%c", currentChar];
   }
   pclose(pipe);
   pipe = NULL;
   
   [fileNames replaceOccurrencesOfString:@"\n" withString:@"|" 
                                 options:NSLiteralSearch range:NSMakeRange(0, [fileNames length])];
   [fileNames deleteCharactersInRange:NSMakeRange([fileNames length]-1, 1)];
   
   return fileNames;
}


- (NSString *)delimitedFileSizesForDirectory:(NSString *)directoryPath
{
   
   NSMutableString    *fileSizes = [[[NSMutableString alloc] init] autorelease];
   NSString           *fileSizesCommand = [NSString stringWithFormat:@"ls -l %@ | awk '{print $2}'\n",
                                           directoryPath];
   FILE               *pipe = popen([fileSizesCommand UTF8String], "r");
   int                currentChar;
   
   while(EOF != (currentChar = fgetc(pipe)))
   {
      [fileSizes appendFormat:@"%c", currentChar];
   }
   pclose(pipe);
   pipe = NULL;
      
   [fileSizes replaceOccurrencesOfString:@"\n" withString:@"," 
                                 options:NSLiteralSearch range:NSMakeRange(0, [fileSizes length])];
   [fileSizes deleteCharactersInRange:NSMakeRange([fileSizes length]-1, 1)];
   
   
   return fileSizes;
}


- (NSImage *)chartForDirectory:(NSString *)directoryPath
{
   NSString       *names = [self delimitedFileNamesForDirectory:directoryPath];
   NSString       *sizes = [self delimitedFileSizesForDirectory:directoryPath];
   NSString       *chartCommand = [NSString stringWithFormat:
      @"http://chart.apis.google.com/chart?cht=p3&chs=600x250&chl=%@&chd=t:%@",
      names, sizes];
   NSURL          *url = [NSURL URLWithString:[chartCommand 
      stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
   NSImage        *chartImage = [[[NSImage alloc] initWithContentsOfURL:url] autorelease];
   
   return chartImage;
}

@end

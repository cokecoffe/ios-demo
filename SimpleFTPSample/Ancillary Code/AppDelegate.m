/*
    File:       AppDelegate.m

    Contains:   Main app controller.

    Written by: DTS

    Copyright:  Copyright (c) 2010 Apple Inc. All Rights Reserved.

    Disclaimer: IMPORTANT: This Apple software is supplied to you by Apple Inc.
                ("Apple") in consideration of your agreement to the following
                terms, and your use, installation, modification or
                redistribution of this Apple software constitutes acceptance of
                these terms.  If you do not agree with these terms, please do
                not use, install, modify or redistribute this Apple software.

                In consideration of your agreement to abide by the following
                terms, and subject to these terms, Apple grants you a personal,
                non-exclusive license, under Apple's copyrights in this
                original Apple software (the "Apple Software"), to use,
                reproduce, modify and redistribute the Apple Software, with or
                without modifications, in source and/or binary forms; provided
                that if you redistribute the Apple Software in its entirety and
                without modifications, you must retain this notice and the
                following text and disclaimers in all such redistributions of
                the Apple Software. Neither the name, trademarks, service marks
                or logos of Apple Inc. may be used to endorse or promote
                products derived from the Apple Software without specific prior
                written permission from Apple.  Except as expressly stated in
                this notice, no other rights or licenses, express or implied,
                are granted by Apple herein, including but not limited to any
                patent rights that may be infringed by your derivative works or
                by other works in which the Apple Software may be incorporated.

                The Apple Software is provided by Apple on an "AS IS" basis. 
                APPLE MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING
                WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT,
                MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING
                THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
                COMBINATION WITH YOUR PRODUCTS.

                IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT,
                INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
                TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
                DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY
                OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
                OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY
                OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR
                OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF
                SUCH DAMAGE.

*/

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, assign) NSInteger             networkingCount;
@end

@implementation AppDelegate

+ (void)initialize
    // Set up our default preferences.  We can't do this in -applicationDidFinishLaunching: 
    // because it's too late; the view controller's -viewDidLoad method has already run 
    // by the time applicationDidFinishLaunching: is called.
{
    if ([self class] == [AppDelegate class]) {
        NSString *      initialDefaultsPath;
        NSDictionary *  initialDefaults;
    
        initialDefaultsPath = [[NSBundle mainBundle] pathForResource:@"InitialDefaults" ofType:@"plist"];
        assert(initialDefaultsPath != nil);
        
        initialDefaults = [NSDictionary dictionaryWithContentsOfFile:initialDefaultsPath];
        assert(initialDefaults != nil);
        
        // If we're running on the device certain defaults don't make any sense 
        // (specifically, the upload defaults, which reference localhost), so 
        // we nix them.
        
        #if ! TARGET_IPHONE_SIMULATOR
        {
            NSMutableDictionary *   initialDefaultsChanged;
            
            initialDefaultsChanged = [initialDefaults mutableCopy];
            assert(initialDefaultsChanged != nil);
            
            [initialDefaultsChanged setObject:@"" forKey:@"CreateDirURLText"];
            [initialDefaultsChanged setObject:@"" forKey:@"PutURLText"];
            
            initialDefaults = initialDefaultsChanged;
        }
        #endif
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:initialDefaults];
    }
}

+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}

@synthesize window      = _window;
@synthesize tabs        = _tabs;

@synthesize networkingCount = _networkingCount;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    #pragma unused(application)
    assert(self.window != nil);
    assert(self.tabs != nil);
    
    [self.window addSubview:self.tabs.view];
    
    self.tabs.selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentTab"];
    
	[self.window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    #pragma unused(application)
    [[NSUserDefaults standardUserDefaults] setInteger:self.tabs.selectedIndex forKey:@"currentTab"];
}

- (NSString *)pathForTestImage:(NSUInteger)imageNumber
    // In order to fully test the send and receive code paths, we need some really big 
    // files.  Rather than carry theshe files around in our binary, we synthesise them. 
    // Specifically, for each test image, we expand the image by an order of magnitude, 
    // based on its image number.  That is, image 1 is not expanded, image 2 
    // gets expanded 10 times, and so on.  We expand the image by simply copying it 
    // to the temporary directory, writing the same data to the file over and over 
    // again.
{
    NSUInteger          power;
    NSUInteger          expansionFactor;
    NSString *          originalFilePath;
    NSString *          bigFilePath;
    NSFileManager *     fileManager;
    NSDictionary *      attrs;
    unsigned long long  originalFileSize;
    unsigned long long  bigFileSize;
    
    assert( (imageNumber >= 1) && (imageNumber <= 4) );

    // Argh, C has no built-in power operator, so I have to do 10 ** (imageNumber - 1)
    // in floating point and then cast back to integer.  Fortunately the range 
    // of values is small enough (1..1000) that floating point isn't going 
    // to cause me any problems.
    
    // On the simulator we expand by an extra order of magnitude; Macs are fast!
    
    power = imageNumber - 1;
    #if TARGET_IPHONE_SIMULATOR
        power += 1;
    #endif
    expansionFactor = (NSUInteger) pow(10, power);

    fileManager = [NSFileManager defaultManager];
    assert(fileManager != nil);
    
    // Calculate paths to both the original file and the expanded file.
    
    originalFilePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"TestImage%zu", (size_t) imageNumber] ofType:@"png"];
    assert(originalFilePath != nil);
    
    bigFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"TestImage%zu.png", (size_t) imageNumber]];
    assert(bigFilePath != nil);
    
    // Get the sizes of each.
    
    attrs = [fileManager attributesOfItemAtPath:originalFilePath error:NULL];
    assert(attrs != nil);
    
    originalFileSize = [[attrs objectForKey:NSFileSize] unsignedLongLongValue];

    attrs = [fileManager attributesOfItemAtPath:bigFilePath error:NULL];
    if (attrs == NULL) {
        bigFileSize = 0;
    } else {
        bigFileSize = [[attrs objectForKey:NSFileSize] unsignedLongLongValue];
    }
    
    // If the expanded file is missing, or the wrong size, create it from scratch.
    
    if (bigFileSize != (originalFileSize * expansionFactor)) {
        NSOutputStream *    bigFileStream;
        NSData *            data;
        const uint8_t *     dataBuffer;
        NSUInteger          dataLength;
        NSUInteger          dataOffset;
        NSUInteger          counter;

        NSLog(@"%5u - %@", (size_t) expansionFactor, bigFilePath);

        data = [NSData dataWithContentsOfMappedFile:originalFilePath];
        assert(data != nil);
        
        dataBuffer = [data bytes];
        dataLength = [data length];
        
        bigFileStream = [NSOutputStream outputStreamToFileAtPath:bigFilePath append:NO];
        assert(bigFileStream != NULL);
        
        [bigFileStream open];
        
        for (counter = 0; counter < expansionFactor; counter++) {
            dataOffset = 0;
            while (dataOffset != dataLength) {
                NSInteger       bytesWritten;
                
                bytesWritten = [bigFileStream write:&dataBuffer[dataOffset] maxLength:dataLength - dataOffset];
                assert(bytesWritten > 0);
                
                dataOffset += bytesWritten;
            }
        }
        
        [bigFileStream close];
    }
    
    return bigFilePath;
}

- (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix
{
    NSString *  result;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    result = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", prefix, uuidStr]];
    assert(result != nil);
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}

- (NSURL *)smartURLForString:(NSString *)str
{
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    
    assert(str != nil);

    result = nil;
    
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat:@"ftp://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"ftp"  options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                // It looks like this is some unsupported URL scheme.
            }
        }
    }
    
    return result;
}

- (BOOL)isImageURL:(NSURL *)url
{
    BOOL        result;
    NSString *  path;
    NSString *  extension;
    
    assert(url != nil);
    
    path = [url path];
    result = NO;
    if (path != nil) {
        extension = [path pathExtension];
        if (extension != nil) {
            result = ([extension caseInsensitiveCompare:@"gif"] == NSOrderedSame)
                  || ([extension caseInsensitiveCompare:@"png"] == NSOrderedSame)
                  || ([extension caseInsensitiveCompare:@"jpg"] == NSOrderedSame);
        }
    }
    return result;
}

- (void)didStartNetworking
{
    self.networkingCount += 1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didStopNetworking
{
    assert(self.networkingCount > 0);
    self.networkingCount -= 1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = (self.networkingCount != 0);
}

@end

/*
     File: TheElementsAppDelegate.m
 Abstract: Application delegate that sets up the application.
  Version: 1.11
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import "TheElementsAppDelegate.h"
#import "PeriodicElements.h"
#import "AtomicElement.h"
#import "ElementsSortedByNameDataSource.h"
#import "ElementsSortedByAtomicNumberDataSource.h"
#import "ElementsSortedBySymbolDataSource.h"
#import "ElementsSortedByStateDataSource.h"
#import "ElementsTableViewController.h"



@implementation TheElementsAppDelegate

@synthesize tabBarController;
@synthesize portraitWindow;


- init {
	if (self = [super init]) {
		// initialize  to nil
		portraitWindow = nil;
		tabBarController = nil;
	}
	return self;
}

- (UINavigationController *)newNavigationControllerWrappingViewControllerForDataSourceOfClass:(Class)datasourceClass {
	// this is entirely a convenience method to reduce the repetition of the code
	// in the setupPortaitUserInterface
	// it returns a retained instance of the UINavigationController class. This is unusual, but 
	// it is necessary to limit the autorelease use as much as possible.
	
	// for each tableview 'screen' we need to create a datasource instance (the class that is passed in)
	// we then need to create an instance of ElementsTableViewController with that datasource instance
	// finally we need to return a UINaviationController for each screen, with the ElementsTableViewController
	// as the root view controller.
	
	// many of these require the temporary creation of objects that need to be released after they are configured
	// and factoring this out makes the setup code much easier to follow, but you can still see the actual
	// implementation here
	
	
	// the class type for the datasource is not crucial, but that it implements the 
	// ElementsDataSource protocol and the UITableViewDataSource Protocol is.
	id<ElementsDataSource,UITableViewDataSource> dataSource = [[datasourceClass alloc] init];
	
	// create the ElementsTableViewController and set the datasource
	ElementsTableViewController *theViewController;	
	theViewController = [[ElementsTableViewController alloc] initWithDataSource:dataSource];
	
	// create the navigation controller with the view controller
	UINavigationController *theNavigationController;
	theNavigationController = [[UINavigationController alloc] initWithRootViewController:theViewController];
	
	// before we return we can release the dataSource (it is now managed by the ElementsTableViewController instance
	[dataSource release];
	
	// and we can release the viewController because it is managed by the navigation controller
	[theViewController release];
	
	return theNavigationController;
}


- (void)setupPortraitUserInterface {
	// a local navigation variable
	// this is reused several times
	UINavigationController *localNavigationController;

    // Set up the portraitWindow and content view
	UIWindow *localPortraitWindow;
	localPortraitWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.portraitWindow = localPortraitWindow;

	// the localPortraitWindow data is now retained by the application delegate
	// so we can release the local variable
	[localPortraitWindow release];

	
    [portraitWindow setBackgroundColor:[UIColor blackColor]];
    
	// Create a tabbar controller and an array to contain the view controllers
	tabBarController = [[UITabBarController alloc] init];
	NSMutableArray *localViewControllersArray = [[NSMutableArray alloc] initWithCapacity:4];
	
	// setup the 4 view controllers for the different data representations
	
	// create the view controller and datasource for the ElementsSortedByNameDataSource
	// wrap it in a UINavigationController, and add that navigationController to the 
	// viewControllersArray array

	localNavigationController = [self newNavigationControllerWrappingViewControllerForDataSourceOfClass:[ElementsSortedByNameDataSource class]];
	[localViewControllersArray addObject:localNavigationController];
	
	// the localNavigationController data is now retained by the application delegate
	// so we can release the local variable
	[localNavigationController release];
	
	
	// repeat the process for the ElementsSortedByAtomicNumberDataSource
	localNavigationController = [self newNavigationControllerWrappingViewControllerForDataSourceOfClass:[ElementsSortedByAtomicNumberDataSource class]];
	[localViewControllersArray addObject:localNavigationController];
	
	// the localNavigationController data is now retained by the application delegate
	// so we can release the local variable
	[localNavigationController release];
	
	
	// repeat the process for the ElementsSortedBySymbolDataSource
	localNavigationController = [self newNavigationControllerWrappingViewControllerForDataSourceOfClass:[ElementsSortedBySymbolDataSource class]];
	[localViewControllersArray addObject:localNavigationController];
	
	// the localNavigationController data is now retained by the application delegate
	// so we can release the local variable
	[localNavigationController release];
	
	
	// repeat the process for the ElementsSortedByStateDataSource
	localNavigationController = [self newNavigationControllerWrappingViewControllerForDataSourceOfClass:[ElementsSortedByStateDataSource class]];
	[localViewControllersArray addObject:localNavigationController];
	
	// the localNavigationController data is now retained by the application delegate
	// so we can release the local variable
	[localNavigationController release];
	
	
	
	// set the tab bar controller view controller array to the localViewControllersArray
	tabBarController.viewControllers = localViewControllersArray;
	
	// the localViewControllersArray data is now retained by the tabBarController
	// so we can release this version
	[localViewControllersArray release];
	
	// set the window subview as the tab bar controller
	[portraitWindow addSubview:tabBarController.view];
	
	// make the window visible
	[portraitWindow makeKeyAndVisible];


}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// configure the portrait user interface
	[self setupPortraitUserInterface];
	
	
}


- (void)dealloc {
	[tabBarController release];
	[portraitWindow release];    
    [super dealloc];
}

@end


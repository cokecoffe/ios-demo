    //
//  YellowViewController.m
//  MultiView
//
//  Created by 睢常明 on 12-1-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "YellowViewController.h"


@implementation YellowViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}




-(IBAction)yellowButtonPressed
{
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Yellowview Button Pressed"
												   message:@"Yellow"
												  delegate:nil 
										 cancelButtonTitle:@"yeah,i dit" 
										 otherButtonTitles:nil];
	[alert show];
	[alert release];
}
@end

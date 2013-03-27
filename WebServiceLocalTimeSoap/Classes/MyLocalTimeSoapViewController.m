//
//  MyLocalTimeSoapViewController.m
//  MyLocalTimeSoap
//
//  Created by Vincent on 10-10-24.
//  Copyright DevDiv Community 2010. All rights reserved.
//

#import "MyLocalTimeSoapViewController.h"
#import "LocalTime.h" 

@implementation MyLocalTimeSoapViewController
@synthesize field;


- (IBAction)buttonPressed:(id)sender
{
	LocalTimeSoapBinding *binding = [[LocalTime LocalTimeSoapBinding] initWithAddress:@"http://www.ripedevelopment.com/webservices/LocalTime.asmx"];
	binding.logXMLInOut = YES;  // to get logging to the console.
	
	LocalTime_LocalTimeByZipCode *request = [[LocalTime_LocalTimeByZipCode alloc] init];
	request.ZipCode = @"29687";  // insert your zip code here.
	
	LocalTimeSoapBindingResponse *resp = [binding LocalTimeByZipCodeUsingParameters:request];
	for (id mine in resp.bodyParts)
	{
		if ([mine isKindOfClass:[LocalTime_LocalTimeByZipCodeResponse class]])
		{
			field.text = [mine LocalTimeByZipCodeResult];
		}
	}}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
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


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end

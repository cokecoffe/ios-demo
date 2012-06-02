//
//  ParserJSON.m
//  UseNetWork
//
//  Created by  vistech on 11-10-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ParserJSON.h"
#import "JSON.h"

#define JSON [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"]
@implementation ParserJSON
@synthesize textView;
@synthesize dic;
@synthesize jsonString;
@synthesize jsonArray;
	
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.textView.text = [[NSString alloc] initWithContentsOfFile:JSON encoding:NSUTF8StringEncoding error:nil];
    [super viewDidLoad];
}


-(void)pressed{
	NSString *path = JSON;
		dic = [[NSMutableDictionary alloc] init];
		jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
		self.textView.text = jsonString;
		dic = [textView.text JSONValue];//对应json文件夹里面的NSString＋SNJSON
		jsonArray = [dic objectForKey:@"result"];
		NSMutableString *json = [[NSMutableString alloc] init];
		for (int i = 0; i < [jsonArray count]; i++) {
					NSDictionary *_dic = [jsonArray objectAtIndex:i];
					NSDictionary *meeting = [_dic objectForKey:@"meeting"];
					[json appendString:[NSString stringWithFormat:@"地址是：%@  创建者是：%@ \n",[meeting objectForKey:@"addr"],[meeting objectForKey:@"creator"]]];
		}
		self.textView.text = json;
	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	[textView release];
	
	[jsonString release];
	
    [super dealloc];
}


@end

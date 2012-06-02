//
//  UseXMLParser.m
//  UseNetWork
//
//  Created by  vistech on 11-10-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UseXMLParser.h"


@implementation UseXMLParser
@synthesize url;
@synthesize xmlParser;

-(id)initWithURL:(NSString *)urlstring{
	if (self = [super init]) {
		self.url = urlstring;
	}
	return self;
}

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
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"解析XML" style:UIBarButtonItemStylePlain target:self action:@selector(buttonPressed)];
    textString = [[NSMutableString alloc] init];
	xmlParser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.url]]];
	[xmlParser setDelegate:self];	
	[super viewDidLoad];
}

-(void)buttonPressed{
	[xmlParser parse];//开始解析
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
		//NSLog(@"elementName:%@        qName:%@",elementName,qName);
	[textString appendString:elementName];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
		//NSLog(@"Characters:%@",string);
	[textString appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
		//NSLog(@"End elementName:%@   qName:%@",elementName,qName);
	[textString appendString:elementName];
    textView.text = @"";
	textView.text = textString;
	
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
	[url release];
	[xmlParser release];
    [super dealloc];
}


@end

    //
//  DetailViewController.m
//  ipad.demo
//
//  Created by wangjun on 10-10-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "DetailViewController.h"
@implementation DetailViewController
@synthesize lable,switch1;
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{

}
-(void)deetail:(id)sender
{
	index=sender;
	
	self.lable.text=[NSString stringWithFormat:@"Row %d,section %d",[index row],[index section]];
	if ([index row]%2==0) {
		self.switch1.on=YES;
	}else {
		self.switch1.on=NO;
	}
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidUnload {
    [super viewDidUnload];
    self.lable=nil;
	self.switch1=nil;
}
- (void)dealloc {
	[self.lable release];
	[self.switch1 release];
    [super dealloc];
}
@end

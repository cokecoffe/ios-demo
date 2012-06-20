//
//  PopContentViewController.m
//  iPad_PopoverView
//
//  Created by Wang keke on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PopContentViewController.h"

@interface PopContentViewController ()

@end

@implementation PopContentViewController
@synthesize a_switch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 200.0);//设置此弹出框的内容尺寸
}

- (void)viewDidUnload
{
    [self setA_switch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
    [a_switch release];
    [super dealloc];
}
@end

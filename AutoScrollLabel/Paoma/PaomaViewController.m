//
//  PaomaViewController.m
//  Paoma
//
//  Created by  cokecoffe on 2012-8-29.
//  Copyright 2012年 tt. All rights reserved.
//

#import "PaomaViewController.h"
#import "AutoScrollLabel.h"

@implementation PaomaViewController
@synthesize inputTextField;

- (IBAction)ChangeText:(id)sender {
    [autoLB setText:self.inputTextField.text];
}

- (void)dealloc
{
    [inputTextField release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    autoLB = [[AutoScrollLabel alloc]initWithFrame:CGRectMake(20.0, 50.0, 100.0, 40.0)];
    autoLB.text = @"Hi Mom!  How are you?  I really ought to write more often.";
    autoLB.textColor = [UIColor yellowColor];
    [self.view addSubview:autoLB];
    [autoLB release];
}


- (void)viewDidUnload
{
    [self setInputTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

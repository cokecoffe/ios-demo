//
//  ViewController.m
//  CheckBox
//
//  Created by 可可 王 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "CheckButton.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)checkButtonClicked:(id)sender
{
    NSLog(@"%@",((CheckButton*)sender).label.text);
    NSLog(@"%d",((CheckButton*)sender).isChecked);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CheckButton *check = [[CheckButton alloc]initWithFrame:CGRectMake(20, 60, 260, 30) Delegate:self];
                                                                      
    check.label.text = @"氙气大灯";

    [self.view addSubview:check];
    
    [check release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

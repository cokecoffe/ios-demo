//
//  RadioButtonViewController.m
//  RadioButton
//
//  Created by ohkawa on 11/03/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RadioButtonViewController.h"
#import "RadioButton.h"


@implementation RadioButtonViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
//first group
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 120)];
    container.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:container];
    
    UILabel *questionText = [[UILabel alloc] initWithFrame:CGRectMake(0,0,280,20)];
    questionText.backgroundColor = [UIColor clearColor];
    questionText.text = @"Which color do you like?";
    [container addSubview:questionText];
    
    RadioButton *rb1 = [[RadioButton alloc] initWithGroupId:@"first group" index:0];
    RadioButton *rb2 = [[RadioButton alloc] initWithGroupId:@"first group" index:1];
    RadioButton *rb3 = [[RadioButton alloc] initWithGroupId:@"first group" index:2];
    
    rb1.frame = CGRectMake(10,30,22,22);
    rb2.frame = CGRectMake(10,60,22,22);
    rb3.frame = CGRectMake(10,90,22,22);
    
    [container addSubview:rb1];
    [container addSubview:rb2];
    [container addSubview:rb3];

    [rb1 release];
    [rb2 release];
    [rb3 release];
    
    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(40, 30, 60, 20)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"Red";
    [container addSubview:label1];
    [label1 release];

    UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(40, 60, 60, 20)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"Green";
    [container addSubview:label2];    
    [label2 release];

    UILabel *label3 =[[UILabel alloc] initWithFrame:CGRectMake(40, 90, 60, 20)];
    label3.backgroundColor = [UIColor clearColor];
    label3.text = @"Blue";
    [container addSubview:label3];
    [label3 release];
    
    [RadioButton addObserverForGroupId:@"first group" observer:self];

    [container release];
    
//second group  
    
    UIView *container_1 = [[UIView alloc] initWithFrame:CGRectMake(20, 160, 280, 120)];
    container_1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:container_1];
    
    UILabel *questionText_1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,280,20)];
    questionText_1.backgroundColor = [UIColor clearColor];
    questionText_1.text = @"Which shape do you like?";
    [container_1 addSubview:questionText_1];
    
    RadioButton *rb1_1 = [[RadioButton alloc] initWithGroupId:@"second group" index:0];
    RadioButton *rb2_1 = [[RadioButton alloc] initWithGroupId:@"second group" index:1];
    RadioButton *rb3_1 = [[RadioButton alloc] initWithGroupId:@"second group" index:2];
    
    rb1_1.frame = CGRectMake(10,30,22,22);
    rb2_1.frame = CGRectMake(10,60,22,22);
    rb3_1.frame = CGRectMake(10,90,22,22);
    
    [container_1 addSubview:rb1_1];
    [container_1 addSubview:rb2_1];
    [container_1 addSubview:rb3_1];
    
    [rb1_1 release];
    [rb2_1 release];
    [rb3_1 release];
    
    UILabel *label1_1 =[[UILabel alloc] initWithFrame:CGRectMake(40, 30, 60, 20)];
    label1_1.backgroundColor = [UIColor clearColor];
    label1_1.text = @"Rect";
    [container_1 addSubview:label1_1];
    [label1_1 release];
    
    UILabel *label2_1 =[[UILabel alloc] initWithFrame:CGRectMake(40, 60, 60, 20)];
    label2_1.backgroundColor = [UIColor clearColor];
    label2_1.text = @"Circle";
    [container_1 addSubview:label2_1];    
    [label2_1 release];
    
    UILabel *label3_1 =[[UILabel alloc] initWithFrame:CGRectMake(40, 90, 60, 20)];
    label3_1.backgroundColor = [UIColor clearColor];
    label3_1.text = @"Angle";
    [container_1 addSubview:label3_1];
    [label3_1 release];
    
    [RadioButton addObserverForGroupId:@"second group" observer:self];
    
    [container_1 release];

        
    
    [super viewDidLoad];
}

-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    NSLog(@"changed to %d in %@",index,groupId);
}

- (void)viewDidUnload
{
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

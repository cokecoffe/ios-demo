//
//  ViewController.m
//  RadioTable
//
//  Created by Wang keke on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myRadioTable;
@synthesize selectBT;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.myRadioTable configeWithDelegate:self DataSource:self SIZE:CGSizeMake(60.0, 400.0) HasIndex:NO];
   
}

- (void)viewDidUnload
{
    [self setMyRadioTable:nil];
    [selectBT release];
    selectBT = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc {
    [myRadioTable release];
    [selectBT release];
    [super dealloc];
}

- (IBAction)SelectBTPressed:(id)sender 
{
    if (popVC == nil)//创建并弹出框
    {
        popVC = [[UIPopoverController alloc]initWithContentViewController:self.myRadioTable];
        [popVC presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        popVC.delegate = self;
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{    
    //销毁弹出框
    [popVC release];
    popVC = nil;
}


#pragma mark DataSource
-(NSDictionary*)provideData
{
    NSString *title = @"标题";
    NSArray *indexarr = [NSArray arrayWithObjects:@"1",@"2",@"3",nil];
    
    NSDictionary*dic1 = [NSDictionary dictionaryWithObject:@"哈哈" forKey:@"1"];
    NSDictionary*dic2 = [NSDictionary dictionaryWithObject:@"呵呵" forKey:@"2"];    
    NSDictionary*dic3 = [NSDictionary dictionaryWithObject:@"嘿嘿" forKey:@"3"];
    
    NSArray *conntarr = [NSArray arrayWithObjects:dic1,dic2,dic3,nil];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",indexarr,@"index",conntarr,@"content",nil];
    return dic;
}

#pragma mark SelectDelegate

-(void)selectItem:(NSDictionary *)dic
{
    NSLog(@"%@",dic);
    self.selectBT.titleLabel.text = [[dic allValues]objectAtIndex:0];
}



@end

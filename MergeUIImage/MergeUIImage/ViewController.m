//
//  ViewController.m
//  MergeUIImage
//
//  Created by keke Wang on 12-8-14.
//  Copyright (c) 2012年 keke Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize ImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    CGSize size = CGSizeMake(320, 480);
    UIGraphicsBeginImageContext(size);
    
//    CGPoint thumbPoint = CGPointMake(0,0);
    UIImage *imageA =  [UIImage imageNamed:@"A.png"];
    
//    [imageA drawAtPoint:thumbPoint];
    [imageA drawInRect:CGRectMake(0, 0, 320, 640)];
    
    UIImage* starred = [UIImage imageNamed:@"B.png"];
    
   // CGPoint starredPoint = CGPointMake(0, 0);
//    [starred drawAtPoint:starredPoint];
    [starred drawInRect:CGRectMake(0, 0, 320, 640)];
    
    UIImage *imageC = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.ImageView setImage:imageC];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [ImageView release];
    [super dealloc];
}
@end

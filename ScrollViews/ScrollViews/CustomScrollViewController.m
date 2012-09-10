//
//  CustomScrollViewController.m
//  ScrollViews
//
//  Created by wangkeke on 12-9-10.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "CustomScrollViewController.h"

@interface CustomScrollViewController ()

@property (nonatomic,strong)UIView *containerView;
-(void)centerScrollViewContents;
@end



@implementation CustomScrollViewController
@synthesize scrollView = _scrollView;
@synthesize containerView = _containerView;


- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.containerView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.containerView.frame = contentsFrame;
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = 1.0f;
    
    [self centerScrollViewContents];
}


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
	// Do any additional setup after loading the view.
    
    // Set up the container view to hold your custom view hierarchy
    CGSize containerSize = CGSizeMake(640.0f, 640.0f);
    self.containerView = [[UIView alloc] initWithFrame:(CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=containerSize}];
    [self.scrollView addSubview:self.containerView];
    
    // Set up your custom view hierarchy
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 640.0f, 80.0f)];
    redView.backgroundColor = [UIColor redColor];
    [self.containerView addSubview:redView];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 560.0f, 640.0f, 80.0f)];
    blueView.backgroundColor = [UIColor blueColor];
    [self.containerView addSubview:blueView];
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(160.0f, 160.0f, 320.0f, 320.0f)];
    greenView.backgroundColor = [UIColor greenColor];
    [self.containerView addSubview:greenView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slow.png"]];
    imageView.center = CGPointMake(320.0f, 320.0f);
    [self.containerView addSubview:imageView];
    
    // Tell the scroll view the size of the contents
    self.scrollView.contentSize = containerSize;
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

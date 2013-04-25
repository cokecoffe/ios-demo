/*
     File: AtomicElementViewController.m
 Abstract: Controller that manages the full tile view of the atomic information,
 creating the reflection, and the flipping of the tile.
  Version: 1.11
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */
 
#import "AtomicElementViewController.h"
#import "AtomicElementView.h"
#import "AtomicElementFlippedView.h"
#import "AtomicElement.h"

@implementation AtomicElementViewController

@synthesize element;
@synthesize atomicElementFlippedView;
@synthesize atomicElementView;
@synthesize containerView;
@synthesize reflectionView;
@synthesize flipIndicatorButton;
@synthesize frontViewIsVisible;


#define reflectionFraction 0.35
#define reflectionOpacity 0.5


- (id)init {
	if (self = [super init]) {
		element = nil;
		atomicElementView = nil;
		atomicElementFlippedView = nil;
		self.frontViewIsVisible=YES;
		self.hidesBottomBarWhenPushed = YES;

	}
	return self;
}


- (void)loadView {	
	// create and store a container view

	UIView *localContainerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	self.containerView = localContainerView;
	[localContainerView release];
	
	containerView.backgroundColor = [UIColor blackColor];
	
	CGSize preferredAtomicElementViewSize = [AtomicElementView preferredViewSize];
	
	CGRect viewRect = CGRectMake((containerView.bounds.size.width-preferredAtomicElementViewSize.width)/2,
								 (containerView.bounds.size.height-preferredAtomicElementViewSize.height)/2-40,
								 preferredAtomicElementViewSize.width,preferredAtomicElementViewSize.height);
	
	// create the atomic element view
	AtomicElementView *localAtomicElementView = [[AtomicElementView alloc] initWithFrame:viewRect];
	self.atomicElementView = localAtomicElementView;
	[localAtomicElementView release];
	
	// add the atomic element view to the containerView
	atomicElementView.element = element;	
	[containerView addSubview:atomicElementView];
	
	atomicElementView.viewController = self;
	self.view = containerView;
	
	// create the atomic element flipped view
	
	AtomicElementFlippedView *localAtomicElementFlippedView = [[AtomicElementFlippedView alloc] initWithFrame:viewRect];
	self.atomicElementFlippedView = localAtomicElementFlippedView;
	[localAtomicElementFlippedView release];
	
	atomicElementFlippedView.element = element;	
	atomicElementFlippedView.viewController = self;


	// create the reflection view
	CGRect reflectionRect=viewRect;

	// the reflection is a fraction of the size of the view being reflected
	reflectionRect.size.height=reflectionRect.size.height*reflectionFraction;
	
	// and is offset to be at the bottom of the view being reflected
	reflectionRect=CGRectOffset(reflectionRect,0,viewRect.size.height);
	
	UIImageView *localReflectionImageView = [[UIImageView alloc] initWithFrame:reflectionRect];
	self.reflectionView = localReflectionImageView;
	[localReflectionImageView release];
	
	// determine the size of the reflection to create
	NSUInteger reflectionHeight=atomicElementView.bounds.size.height*reflectionFraction;
	
	// create the reflection image, assign it to the UIImageView and add the image view to the containerView
	reflectionView.image=[self.atomicElementView reflectedImageRepresentationWithHeight:reflectionHeight];
	reflectionView.alpha=reflectionOpacity;
	
	[containerView addSubview:reflectionView];

	
	UIButton *localFlipIndicator=[[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
	self.flipIndicatorButton=localFlipIndicator;
	[localFlipIndicator release];
	
	// front view is always visible at first
	[flipIndicatorButton setBackgroundImage:[UIImage imageNamed:@"flipper_list_blue.png"] forState:UIControlStateNormal];
	
	UIBarButtonItem *flipButtonBarItem;
	flipButtonBarItem=[[UIBarButtonItem alloc] initWithCustomView:flipIndicatorButton];
	
	[self.navigationItem setRightBarButtonItem:flipButtonBarItem animated:YES];
	[flipButtonBarItem release];
	
	[flipIndicatorButton addTarget:self action:@selector(flipCurrentView) forControlEvents:(UIControlEventTouchDown   )];
	 

}



- (void)flipCurrentView {
	NSUInteger reflectionHeight;
	UIImage *reflectedImage;
	
	// disable user interaction during the flip
	containerView.userInteractionEnabled = NO;
	flipIndicatorButton.userInteractionEnabled = NO;
	
	// setup the animation group
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(myTransitionDidStop:finished:context:)];
	
	// swap the views and transition
    if (frontViewIsVisible==YES) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:containerView cache:YES];
        [atomicElementView removeFromSuperview];
        [containerView addSubview:atomicElementFlippedView];
		
		
		// update the reflection image for the new view
		reflectionHeight=atomicElementFlippedView.bounds.size.height*reflectionFraction;
		reflectedImage = [atomicElementFlippedView reflectedImageRepresentationWithHeight:reflectionHeight];
		reflectionView.image=reflectedImage;
    } else {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:containerView cache:YES];
        [atomicElementFlippedView removeFromSuperview];
        [containerView addSubview:atomicElementView];
		// update the reflection image for the new view
		reflectionHeight=atomicElementView.bounds.size.height*reflectionFraction;
		reflectedImage = [atomicElementView reflectedImageRepresentationWithHeight:reflectionHeight];
		reflectionView.image=reflectedImage;
    }
	[UIView commitAnimations];
	
	
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(myTransitionDidStop:finished:context:)];

	if (frontViewIsVisible==YES)
	{
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:flipIndicatorButton cache:YES];
		[flipIndicatorButton setBackgroundImage:element.flipperImageForAtomicElementNavigationItem forState:UIControlStateNormal];
	}
	else
	{
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:flipIndicatorButton cache:YES];
		[flipIndicatorButton setBackgroundImage:[UIImage imageNamed:@"flipper_list_blue.png"] forState:UIControlStateNormal];
		
	}
	[UIView commitAnimations];
	frontViewIsVisible=!frontViewIsVisible;
}


- (void)myTransitionDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	// re-enable user interaction when the flip is completed.
	containerView.userInteractionEnabled = YES;
	flipIndicatorButton.userInteractionEnabled = YES;

}



- (void)dealloc {
	[atomicElementView release];
	[reflectionView release];
	[atomicElementFlippedView release];
	[element release];
	[super dealloc];
}


@end

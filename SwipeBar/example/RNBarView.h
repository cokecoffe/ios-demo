//
//  RNBarView.h
//  RNSwipeBar
//
//  Created by Ryan Nystrom on 4/24/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RNBarViewDelegate

@required

- (void)mainButtonWasPressed:(id)sender;

@end

@interface RNBarView : UIView

@property (strong) NSObject <RNBarViewDelegate> *delegate;

- (IBAction)onOne:(id)sender;
- (IBAction)onTwo:(id)sender;
- (IBAction)onThree:(id)sender;
- (IBAction)onFour:(id)sender;
- (IBAction)onMainButton:(id)sender;

@end


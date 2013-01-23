//
//  RNBarView.m
//  RNSwipeBar
//
//  Created by Ryan Nystrom on 4/24/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "RNBarView.h"

@implementation RNBarView

@synthesize delegate = _delegate;

- (IBAction)onOne:(id)sender {
    NSLog(@"one");
}

- (IBAction)onTwo:(id)sender {
    NSLog(@"two");
}

- (IBAction)onThree:(id)sender {
    NSLog(@"three");
}

- (IBAction)onFour:(id)sender {
    NSLog(@"four");
}

- (IBAction)onMainButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(mainButtonWasPressed:)]) {
        [self.delegate mainButtonWasPressed:self];
    }
}
@end

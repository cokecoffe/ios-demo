//  Created by Ryan Nystrom on 4/14/12.
//
//  Copyright (C) 2012 Ryan Nystrom
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>

@protocol RNSwipeBarDelegate

@optional

- (void)swipeBarDidAppear:(id)sender;
- (void)swipeBarDidDisappear:(id)sender;
- (void)swipebarWasSwiped:(id)sender;

@end

@interface RNSwipeBar : UIView
{
    BOOL _isHidden;
    BOOL _canMove;
    float _height;
    float _padding;
    float _animationDuration;
}

@property (strong, nonatomic) UIView *parentView;
@property (strong, nonatomic) UIView *barView;
@property (weak, nonatomic) NSObject <RNSwipeBarDelegate> *delegate;

// Optional initializers
- (id)initWithMainView:(UIView*)view;
- (id)initWithMainView:(UIView*)view barView:(UIView*)barView;

// Set the amount of padding to be displayed above the bottom of the screen
- (void)setPadding:(float)padding;

// Selection of methods to hide/show the bar
// Variety, for your semantics
- (void)show:(BOOL)shouldShow;
- (void)hide:(BOOL)shouldHide;
- (void)toggle;

@end
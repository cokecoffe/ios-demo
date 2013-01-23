RNSwipeBar
=========

RNSwipeBar is a lightweight iOS widget, optimized for iPhone/iPod Touch projects, that takes back roughly 44px of UI space. The bar works rather simply: create a UIView that contains all of your necessary objects and images for the bar. This is usually created completely custom. I left out any bar building parts because I want to leave it open ended how this is used. If you are interested in *how* to create a custom bar for this widget, please take a look at the included example.

#### Images

<img src="http://github.com/rnystrom/RNSwipeBar/raw/master/images/open.png" width="200" style="box-shadow: 2px 2px 5px #000: margin: 0 15px;" />
<img src="http://github.com/rnystrom/RNSwipeBar/raw/master/images/closed.png" width="200" style="box-shadow: 2px 2px 5px #000: margin: 0 15px;" />

#### Video

[Watch on YouTube](http://www.youtube.com/watch?v=pqEZgcvQUlM)

### Installation

Simple. Drag and drop RNSwipeBar.h and RNSwipeBar.m into your project. RNSwipeBar is designed to be used with ARC, iOS 4.3+ projects **only**. If you really, really need this project in non-ARC I wouldn't mind revising it (but you should really be targetting iOS 5+ anyways).

### Usage

Simply initialize the RNSwipeBar, set up your properties, and add it to your view. RNSwipeBar will handle gestures by itself. 

    RNSwipeBar *swipeBar = [[RNSwipeBar alloc] initWithMainView:self.view];
    [swipeBar setPadding:20.0f];
    [self.view addSubview:swipeBar];

I did include some convenience methods to handle toggling of the bar without the swipe gestures.

    - (void)show:(BOOL)shouldShow;
    - (void)hide:(BOOL)shouldHide;
    - (void)toggle;

Bear in mind that <code>show:</code> and <code>hide:</code> are exactly the same method, just opposite effects. The idea is to allow you some flexibility in fitting your semantics. For me, <code>toggle</code> is the most frequently used.

### Customizing

Really the only thing that you need to worry about is the padding. Here I'm using padding as a property to describe how far (in pixels) from the bottom of your view should the RNSwipeBar stick out.

### License

Copyright (C) 2012 Ryan Nystrom
 
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"  ), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publis    h, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR A    NY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[MIT License](http://www.opensource.org/licenses/mit-license.php)

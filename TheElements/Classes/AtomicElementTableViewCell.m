/*
     File: AtomicElementTableViewCell.m
 Abstract: Draws the tableview cell and lays out the subviews.
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

#import "AtomicElementTableViewCell.h"
#import "AtomicElement.h"
#import "AtomicElementTileView.h"

@implementation AtomicElementTableViewCell

@synthesize element;
@synthesize elementTileView;
@synthesize labelView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		element = nil;
		elementTileView = nil;
		labelView = nil;
				
		// create the elementTileView and the labelView
		// both of these will be laid out again by the layoutSubviews method
		AtomicElementTileView *tileView = [[AtomicElementTileView alloc] initWithFrame:CGRectZero];
		self.elementTileView = tileView;
		[self.contentView addSubview:tileView];
		[tileView release];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
		// set the label view to have a clear background and a 20 point font
		label.backgroundColor = [UIColor clearColor];
		label.font = [UIFont boldSystemFontOfSize:20];
		self.labelView = label;
		[self.contentView addSubview:label];
		[label release];
		
		
		// add both the label and elementTile to the TableViewCell view
    }
    return self;
}


- (void)layoutSubviews {
	[super layoutSubviews];

	// determine the content rect for the cell. This will change depending on the
	// style of table (grouped vs plain)
	CGRect contentRect = self.contentView.bounds;
	
	// position the image tile in the content rect.
	CGRect elementTileRect = self.contentView.bounds;
	elementTileRect.size = [AtomicElementTileView preferredViewSize];
	elementTileRect = CGRectOffset(elementTileRect,10,3);
	elementTileView.frame = elementTileRect;
	
	// position the elment name in the content rect
	CGRect labelRect = contentRect;
	labelRect.origin.x = labelRect.origin.x+56;
	labelRect.origin.y = labelRect.origin.y+3;
	labelView.frame = labelRect;	
}


- (void)dealloc {
	[element release];
	[elementTileView release];
	[labelView release];
    [super dealloc];
}


// the element setter
// we implement this because the table cell values need
// to be updated when this property changes, and this allows
// for the changes to be encapsulated
- (void)setElement:(AtomicElement *)anElement {
	if (anElement != element) {
		[element release];
		[anElement retain];
		element = anElement;
	}
	elementTileView.element = element;
	labelView.text = element.name;
	[elementTileView setNeedsDisplay];
	[labelView setNeedsDisplay];
}

@end

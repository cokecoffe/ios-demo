//
//  FilterButton.m
//  Buyer
//
//  Created by keke Wang on 13-1-28.
//  Copyright (c) 2013年 checkauto. All rights reserved.
//

#import "FilterButton.h"

@implementation FilterButton

-(void)setTitle:(NSString*)title Tag:(NSInteger)tag
{
    [self.button setTitle:title forState:UIControlStateNormal];

    [self.button setTag:tag];
    [self.deleteButton setTag:tag];
    [self setTag:tag];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    [_button release];
    [_deleteButton release];
    [super dealloc];
}
@end

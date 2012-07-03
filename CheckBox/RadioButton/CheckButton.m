//
//  CheckButton.m
//  AllApart
//
//  Created by steven yang on 11-1-18.
//  Copyright 2011 kmyhy. All rights reserved.
//

#import "CheckButton.h"
#import "Utils.h"

@implementation CheckButton
@synthesize label,icon,value,delegate,gap;
@synthesize style;
-(id)initWithFrame:(CGRect)_frame
{
	if (self=[super initWithFrame:_frame]) {
        frame=_frame; 
        gap=8;
        [self setStyle:CheckButtonStyleDefault];//默认风格为方框（多选）样式

        icon=[[UIImageView alloc]initWithFrame:
              CGRectMake(0, 0, frame.size.height, frame.size.height)];
        [self addSubview:icon];
        label=[[UILabel alloc]initWithFrame:CGRectMake(icon.frame.size.width+gap, 0, 
                                      frame.size.width-icon.frame.size.width-gap,
                                     frame.size.height)];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:15];
        label.textColor=[UIColor blackColor];
        [self addSubview:label];
        [self addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        label.textAlignment=UITextAlignmentLeft;
        enable=YES;
        checked=NO;
	}
	return self;
}
-(void)layoutSubviews{

    label.frame=CGRectMake(icon.frame.size.width+gap, 0, 
                                  frame.size.width-icon.frame.size.width-gap,
                                                 frame.size.height);

 }
-(CheckButtonStyle)style{
	return style;
}
-(void)setStyle:(CheckButtonStyle)st{
	style=st;
	switch (style) {
		case CheckButtonStyleDefault:
			
		case CheckButtonStyleBox:
			checkname=@"checked.png";
			uncheckname=@"unchecked.png";
			break;
		case CheckButtonStyleRadio:
			checkname=@"radio.png";
			uncheckname=@"unradio.png";
			break;
		default:
			break;
	}
	[self setChecked:checked];
}
-(BOOL)checked{
	return checked;
}
-(void)setChecked:(BOOL)b{
	if(enable){  // 如果控件可用
		checked=b;
		if (checked) {
			//[icon setImage:[UIImage imageNamed:checkname]];
			[icon setImage:[UIImage imageWithContentsOfFile:getMyBundlePath(checkname)]];
			//		NSLog(@"delegate=%@",delegate);
		}else {
			//[icon setImage:[UIImage imageNamed:uncheckname]];
			[icon setImage:[UIImage imageWithContentsOfFile:getMyBundlePath(uncheckname)]];
		}
		
	}else{
        checked=NO;
        [self.icon setImage:[UIImage imageWithContentsOfFile:getMyBundlePath(uncheckname)]];
    }
}
-(void)clicked:(id)sender{
    if(enable){
        if (delegate!=nil) {//如果使用了RadioGroup，需要实现特殊逻辑比如单选
            SEL sel=NSSelectorFromString(@"checkButtonClicked:");
            if([delegate respondsToSelector:sel]){
                [delegate performSelector:sel withObject:sender]; 
            }  
        }else {
            [self setChecked:!checked];
        }
    }
}
-(void)dealloc{

	value=nil;delegate=nil;
	[label release];
	[icon release];
	[super dealloc];
}
-(void)resizeFrameToRect:(CGRect)rect{
	self.frame=rect;
	icon.frame=CGRectMake(icon.frame.origin.x, 
						  icon.frame.origin.y, 
						  rect.size.height,
						  rect.size.height);
	label.frame=CGRectMake(label.frame.origin.x+gap, 
						   label.frame.origin.y,
						   rect.size.width-rect.size.height-gap,
						   rect.size.height);
}
-(BOOL)enable{
    return enable;
}
-(void)setEnable:(BOOL)b{
    enable=b;
    if (!b) {
        [self setChecked:NO];
    }
}
@end

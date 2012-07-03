//
//  CheckButton.h
//  AllApart
//
//  Created by steven yang on 11-1-18.
//  Copyright 2011 kmyhy. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CGUtils.h"

typedef enum {
    CheckButtonStyleDefault = 0,
    CheckButtonStyleBox = 1,
    CheckButtonStyleRadio = 2
} CheckButtonStyle;
#import <Foundation/Foundation.h>

@interface CheckButton : UIControl {
    BOOL checked,enable;
	NSString *checkname,*uncheckname;//勾选／反选时的图片文件名
	CGRect frame;
//	int gap;
}
@property (assign,nonatomic)id value,delegate;
@property (retain,nonatomic)UILabel* label;
@property (retain,nonatomic)UIImageView* icon;
@property (assign)CheckButtonStyle style;
@property (assign,getter = checked,setter = setChecked:)BOOL checked;
@property (assign,getter = enable,setter = setEnable:)BOOL enable;
@property (assign)int gap;

-(CheckButtonStyle)style;
-(void)setStyle:(CheckButtonStyle)st;
-(void)resizeFrameToRect:(CGRect)rect;
-(void)layoutSubviews;

@end

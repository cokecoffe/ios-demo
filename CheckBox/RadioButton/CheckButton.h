//
//  CheckButton.h
//  AllApart
//
//  Created by steven yang on 11-1-18.
//  Copyright 2011 kmyhy. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum {
    CheckButtonStyleDefault = 0,//复选
    CheckButtonStyleBox = 1,//复选
    CheckButtonStyleRadio = 2//单选
} CheckButtonStyle;

@interface CheckButton : UIControl {
  
    UILabel * label ;
    UIImageView * icon ;
    BOOL checked ;
    id  delegate ;
}
@property ( retain , nonatomic ) id delegate;
@property ( retain , nonatomic )UILabel* label;
@property ( retain , nonatomic )UIImageView* icon;


-( id )initWithFrame:( CGRect ) frame Delegate:(id)_delegate;
-( BOOL )isChecked;
-( void )setChecked:( BOOL )status;
@end
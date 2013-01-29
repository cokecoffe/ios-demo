//
//  FilterButton.h
//  Buyer
//
//  Created by keke Wang on 13-1-28.
//  Copyright (c) 2013年 checkauto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterButton : UIView

@property (retain, nonatomic) IBOutlet UIButton *button;
@property (retain, nonatomic) IBOutlet UIButton *deleteButton;

-(void)setTitle:(NSString*)title Tag:(NSInteger)tag;

@end

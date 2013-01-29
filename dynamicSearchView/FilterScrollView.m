//
//  FilterScrollView.m
//  Buyer
//
//  Created by keke Wang on 13-1-28.
//  Copyright (c) 2013年 checkauto. All rights reserved.
//

#import "FilterScrollView.h"
#import "FilterButton.h"

#define k_BUTTON_WIDTH 80.0
#define k_BUTTON_HEIGHT 44.0
#define k_BUTTON_GAP 10.0

@interface FilterScrollView ()

@property(retain,nonatomic)NSMutableArray *buttons;

@end

@implementation FilterScrollView

-(void)addButton
{
    //已有的 右移
    for (FilterButton *bt in self.subviews) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             bt.frame = CGRectMake(bt.frame.origin.x+bt.bounds.size.width,0, bt.bounds.size.width, bt.bounds.size.height);
                         }completion:^(BOOL finished) {
                             
                         }];
    }    
    
    //添加1个新项
    NSDictionary *dic = [self.FilterdataSource FiterDataForView:self atIndex:0];

    FilterButton *newBt = (FilterButton*)[[NSBundle mainBundle] loadNibNamed:@"FilterButton" owner:self options:nil][0];
    [newBt setTitle:dic[@"title"] Tag:[dic[@"tag"] intValue]];
    [newBt.deleteButton addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];//响应
    
    newBt.frame = CGRectMake(0,0, newBt.bounds.size.width, newBt.bounds.size.height);
    [self addSubview:newBt];

    self.contentSize = CGSizeMake((k_BUTTON_GAP+k_BUTTON_WIDTH)*[self.FilterdataSource numberInFiterView:self], self.frame.size.height);
}


-(void)deleteButton:(UIButton*)sender
{
    int flag = 0;
    for (int i = 0; i<[self.FilterdataSource numberInFiterView:self]; i++) {
        NSDictionary *dic = [self.FilterdataSource FiterDataForView:self atIndex:i];

        if (flag == 0 && sender.tag == [dic[@"tag"] intValue]) {
            [sender.superview removeFromSuperview];
            [self.Filterdelegate deleteFilterAtIndex:i inView:self];
            flag = 1;
            i--;
            continue;
        }
        
        if (flag == 1) {//删除后所有右侧的 向左移动
            
            for (FilterButton *bt in self.subviews) {
                if (bt.tag == [dic[@"tag"] intValue]) {
                    [UIView animateWithDuration:0.3
                                     animations:^{
                                         bt.frame =  CGRectMake(bt.frame.origin.x-bt.bounds.size.width,0, bt.bounds.size.width, bt.bounds.size.height);
                                     }completion:^(BOOL finished) {
                                         
                                     }];                    
                }
            }
        }
    }
    self.contentSize = CGSizeMake((k_BUTTON_GAP+k_BUTTON_WIDTH)*[self.FilterdataSource numberInFiterView:self], self.frame.size.height);
}

-(void)removeAllbuttons
{
    [[self subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.contentSize = CGSizeMake((k_BUTTON_GAP+k_BUTTON_WIDTH)*[self.FilterdataSource numberInFiterView:self], self.frame.size.height);
}

@end

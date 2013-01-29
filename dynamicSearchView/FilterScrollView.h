//
//  FilterScrollView.h
//  Buyer
//
//  Created by keke Wang on 13-1-28.
//  Copyright (c) 2013年 checkauto. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FilterScrollView;
@protocol FilterScrollViewDataSource <NSObject>
-(NSDictionary*)FiterDataForView:(FilterScrollView*)view atIndex:(NSInteger)index;//条件:title:tag
-(NSInteger)numberInFiterView:(FilterScrollView*)view;//个数
@end

@protocol FilterScrollViewDelegate <NSObject>
-(void)deleteFilterAtIndex:(NSInteger)index inView:(FilterScrollView*)view;//删除一个条件
@end


@interface FilterScrollView : UIScrollView

@property(assign,nonatomic) id<FilterScrollViewDataSource>FilterdataSource;
@property(assign,nonatomic) id<FilterScrollViewDelegate>Filterdelegate;

-(void)addButton;
-(void)removeAllbuttons;

@end



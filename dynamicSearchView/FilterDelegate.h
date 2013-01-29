//
//  FilterDelegate.h
//  Buyer
//
//  Created by keke Wang on 12-10-13.
//  Copyright (c) 2012年 checkauto. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FilterDelegate <NSObject>

-(void)FinishedSelectwithArea:(NSString*)a_arr Price:(NSString *)p_arr Year:(NSString*)y_arr;

@end

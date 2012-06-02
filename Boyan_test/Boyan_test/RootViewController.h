//
//  RootViewController.h
//  Boyan_test
//
//  Created by 可可 王 on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


/************************************************
*
* index->label_name(key)->textfield.text(value) 
*
*************************************************/

#import <UIKit/UIKit.h>

#define FileName @"DataFile"

@interface RootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{

    NSArray *listData;
    NSMutableDictionary *AllDataDic;
}
@property (nonatomic,retain) NSArray *listData;
@property (nonatomic,retain) NSMutableDictionary *AllDataDic;

-(NSString*)dataFilePath;
-(void)SaveInfo;
-(BOOL)readInfo;

@end

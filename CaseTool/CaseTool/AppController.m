//
//  AppController.m
//  CaseTool
//
//  Created by 可可 王 on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

@implementation AppController

-(IBAction)uppercase:(id)sender
{
    [resultField setStringValue:[[textField stringValue] uppercaseString]];
}
-(IBAction)lowercase:(id)sender;
{
    [resultField setStringValue:[[textField stringValue] lowercaseString]];
}
-(void)awakeFromNib
{
    [textField setStringValue:@"请输入"];
    [resultField setStringValue:@"结果:"];
}

@end

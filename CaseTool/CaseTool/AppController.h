//
//  AppController.h
//  CaseTool
//
//  Created by 可可 王 on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppController : NSObject
{
    IBOutlet NSTextField *textField;
    IBOutlet NSTextField *resultField;
}

-(IBAction)uppercase:(id)sender;
-(IBAction)lowercase:(id)sender;
@end

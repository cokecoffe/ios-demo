//
//  RetainTracker.m
//  Retaincount
//
//  Created by 可可 王 on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RetainTracker.h"

@implementation RetainTracker

-(id)init
{
    if (self = [super init]) {
        NSLog(@"Init rc = %lu",[self retainCount]);
    }
    return self;
}

-(void)dealloc
{
    NSLog(@"Dealloc Bye Bye");
    [super dealloc];
}


@end

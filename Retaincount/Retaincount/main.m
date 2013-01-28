//
//  main.m
//  Retaincount
//
//  Created by 可可 王 on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RetainTracker.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Hello, World!");
        
        RetainTracker *tracker = [RetainTracker new];
        
        [tracker retain];//计数+1
        NSLog(@"After retain rc = %lu",[tracker retainCount]);
        
        
        [tracker autorelease];//加入自动释放池,自动释放池release的时候，池中所有的对象都会发送一条release消息
        NSLog(@"After autorelease rc = %lu",[tracker retainCount]);
        
        
        [tracker release];//计数-1
        NSLog(@"After release rc = %lu",[tracker retainCount]);
        
    }
    return 0;
}


//
//  main.m
//  copy
//
//  Created by Wang keke on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSString *str = [[NSString alloc]initWithFormat:@"123"];//[NSString stringWithFormat:@"123"];
        
        NSLog(@"str:%p recount = %ld",str,[str retainCount]);
        
        NSString *cpstr = [str copy];
        
        
        NSLog(@"cpstr:%p recount = %ld",cpstr,[cpstr retainCount]);
        
        
        [cpstr retain];
        NSLog(@"str:%p recount = %ld",str,[str retainCount]);
         NSLog(@"cpstr:%p recount = %ld",cpstr,[cpstr retainCount]);
        
        
    }
    return 0;
}


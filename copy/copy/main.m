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
        
#if 0
        //不可变对象的copy
        NSString *str = [NSString stringWithFormat:@"123"];
                
        NSString *cpstr = [str copy];//浅拷贝，str:2 ,cpstr:2
       
        NSLog(@"STR:%p recount = %ld",str,[str retainCount]);
        NSLog(@"CPstr:%p recount = %ld",cpstr,[cpstr retainCount]);
#endif
        
#if 0
        //不可变对象的mutableCopy
        NSString *str = [NSString stringWithFormat:@"123"];
        
        NSMutableString *cpstr = [str mutableCopy];//深拷贝，str:1 ,cpstr:1
        
        NSLog(@"STR:%p recount = %ld",str,[str retainCount]);
        NSLog(@"CPstr:%p recount = %ld",cpstr,[cpstr retainCount]);
#endif
        
     
#if 0
        //可变对象的copy
        NSString *str = [NSMutableString stringWithFormat:@"123"];
        
        NSString *cpstr = [str copy];//深拷贝，str:1 ,cpstr:1
        
        NSLog(@"STR:%p recount = %ld",str,[str retainCount]);
        NSLog(@"CPstr:%p recount = %ld",cpstr,[cpstr retainCount]);
#endif        

#if 1
        //可变对象的mutableCopy
        NSString *str = [NSMutableString stringWithFormat:@"123"];
        
        NSMutableString *cpstr = [str mutableCopy];//深拷贝，str:1 ,cpstr:1
        
        NSLog(@"STR:%p recount = %ld",str,[str retainCount]);
        NSLog(@"CPstr:%p recount = %ld",cpstr,[cpstr retainCount]);
#endif
        
#if 0
        NSArray *array = [NSArray arrayWithObjects:@"a",@"b",@"c",nil];
        
        NSArray *cparr = [array copy];
        
        NSLog(@"array:%p recount = %ld",array,[array retainCount]);
        NSLog(@"cpArray:%p recount = %ld",cparr,[cparr retainCount]);
#endif
        
#if 0
        NSArray *array = [NSArray arrayWithObjects:@"a",@"b",@"c",nil];
        
        NSArray *cparr = [array mutableCopy];
        
        NSLog(@"array:%p recount = %ld object0:%p",array,[array retainCount],[array objectAtIndex:0]);
        NSLog(@"cpArray:%p recount = %ld object1:%p",cparr,[cparr retainCount],[cparr objectAtIndex:0]);
#endif
        
        
                
    }
    return 0;
}


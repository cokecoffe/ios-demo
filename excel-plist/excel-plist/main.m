//
//  main.m
//  excel-plist
//
//  Created by keke Wang on 12-8-16.
//  Copyright (c) 2012年 keke Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"File" ofType:@"txt"];
        NSString *contents = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSArray *contentsArray = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

        
        
        NSString *docs = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/xxxx.plist"] ;
        
        NSMutableDictionary *root = [[NSMutableDictionary alloc]init];
        
        NSInteger idx;
        for (idx = 0; idx < contentsArray.count; idx++) {
            NSString* currentContent = [contentsArray objectAtIndex:idx];
            NSArray* timeDataArr = [currentContent componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";"]];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:[timeDataArr objectAtIndex:0] forKey:@"mapID"];//mapID
            [dic setObject:[timeDataArr objectAtIndex:1] forKey:@"flag"];//区域类型
            
            NSDictionary *points = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"x",[NSNumber numberWithInt:0],@"y",nil];
            [dic setObject:points forKey:@"points"];//坐标
            
            [root setObject:dic forKey:[timeDataArr objectAtIndex:5]];//
        }
        [root writeToFile:docs atomically:YES];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

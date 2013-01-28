//
//  main.m
//  FileWalker
//
//  Created by 可可 王 on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSFileManager *manager;
        manager = [NSFileManager defaultManager];
        
        NSString *home;
        home = [@"~" stringByExpandingTildeInPath];//获得家目录的全路径
         
        NSLog(@"home is %@",home);
        
       // NSDirectoryEnumerator *direnum;
       // direnum = [manager enumeratorAtPath:home];//通知manger要迭代home路径
        
        NSMutableArray *files;
        files = [NSMutableArray arrayWithCapacity:42];
        
       /* NSString *filename;
        while (filename = [direnum nextObject]) {//迭代home路径下的每一个文件
            if ([[filename pathExtension]
                isEqualTo:@"pdf"]) {                
                [files addObject:filename];//将指定文件类型的文件存入数组
            }
        }*/
        //快速枚举
        for (NSString *filename in [manager enumeratorAtPath:home]) {
            if ([[filename pathExtension]
                 isEqualTo:@"pdf"]) {                
                [files addObject:filename];//将指定文件类型的文件存入数组
            }
        }
        
                        
        for (NSString *fn in files){//输出
            NSLog(@"%@",fn);
        }
        
    }
    return 0;
}


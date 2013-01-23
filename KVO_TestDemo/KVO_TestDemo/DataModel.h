//
//  DataModel.h
//  KVO_TestDemo
//
//  Created by 勤 姚 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
{
    NSInteger needObserverValue;
    
}

@property (nonatomic,assign)NSInteger needObserverValue;
@property (nonatomic,retain)NSString *dataString;

@end

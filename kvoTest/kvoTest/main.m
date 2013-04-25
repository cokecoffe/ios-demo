//
//  main.m
//  kvoTest
//
//  Created by cokecoffe on 13-4-15.
//  Copyright (c) 2013年 uxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - A

@interface A : NSObject

@property (nonatomic,readonly,strong) NSString *something;

-(void)changeValueForSomething;

@end

@interface A ()

@property (nonatomic,readwrite,strong) NSString *something;//私有的setter方法

@end


@implementation A

-(id)init{
    self = [super init];
    if (self) {
        self.something = @"old";
    }
    return self;
}

-(void)changeValueForSomething{
    self.something = @"new";
}

@end

#pragma mark - B

@interface B : NSObject

@end


@implementation B

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"B noticed.");
}

@end


#pragma mark - appDelegate

@interface AppDelegate : NSObject <UIApplicationDelegate>

@property (strong) A *a;
@property (strong) B *b;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
    self.a = [[A alloc]init];
    
    self.b= [[B alloc]init];
    
    [self.a addObserver:self.b forKeyPath:@"something" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.a changeValueForSomething];
    
}

@end


#pragma mark - main

int main(int argc, char *argv[])
{
    @autoreleasepool {
        
        UIApplicationMain(argc, argv, nil, @"AppDelegate");
        
    }
    return 0;
}


//
//  CCLevelView.m
//  LevelView
//
//  Created by keke Wang on 13-7-11.
//  Copyright (c) 2013年 keke Wang. All rights reserved.
//

#import "CCLevelView.h"

@implementation CCLevelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setLevel:(NSInteger)level
{
    if (level<0||level>5) {
        return;
    }
    
    if (level!=_level) {
        _level = level;
        
        for (int i = 1; i<level+1; i++) {
            UIImageView *star = [self valueForKey:[NSString stringWithFormat:@"star%d",i]];
            
            [self performSelector:@selector(scaleForview:) withObject:star afterDelay:0.3+0.1*i];
        }
    }
}

-(void)scaleForview:(UIImageView*)star{
    
    star.highlighted = YES;
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         CGRect newframe = star.frame;
                         newframe.size.width*=2;
                         newframe.size.height*=2;
                         star.frame = newframe;
                         
                     }completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              
                                              CGRect newframe = star.frame;
                                              newframe.size.width/=2;
                                              newframe.size.height/=2;
                                              star.frame = newframe;
                                              
                                          }completion:^(BOOL finished) {
                                              
                                          }];
                     }];
}

@end

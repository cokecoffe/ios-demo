//
//  myview.m
//  mouse
//
//  Created by Wang keke on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "myview.h"

@implementation myview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

#define WIDTH 32

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pointLocation" ofType:@"plist"];
    NSMutableDictionary* dict =  [ [ NSMutableDictionary alloc ] initWithContentsOfFile:filePath];
    
    NSInteger x = 0;
    NSInteger y = 0;
    for (NSString *name in [dict allKeys]) {
        NSLog(@"name = %@",name);
        for (NSString *position in [dict objectForKey:name]) {      
            NSArray *xy = [position componentsSeparatedByString: @"-"];
            NSLog(@"positionx = :%@,y = %@",[xy objectAtIndex:0],[xy objectAtIndex:1]);
            x = [[xy objectAtIndex:1]intValue]*WIDTH+WIDTH;
            y = [[xy objectAtIndex:0]intValue]*WIDTH;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            button.frame = CGRectMake(x, y, WIDTH, WIDTH);
            [self addSubview:button];
        }
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint startP = [touch locationInView:self];
    
    CGAffineTransform scaleTrans =CGAffineTransformMakeScale(1.0, 1.0);

    [arrows setTransform:scaleTrans];    
    [arrows setAlpha:1.0];
    [arrows setCenter:startP];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint startP = [touch locationInView:self];
    
    [arrows setCenter:startP];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    
    CGAffineTransform scaleTrans =CGAffineTransformMakeScale(0.1, 0.1);
    [arrows setTransform:scaleTrans];
    [arrows setAlpha:0.0];
    
    [UIView commitAnimations];    
}

@end

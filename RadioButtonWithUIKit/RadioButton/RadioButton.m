//
//  RadioButton.m
//  RadioButton
//
//  Created by ohkawa on 11/03/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RadioButton.h"

@interface RadioButton()
-(void)defaultInit;
-(void)otherButtonSelected:(id)sender;
-(void)handleButtonTap:(id)sender;
@end

@implementation RadioButton

@synthesize groupId=_groupId;
@synthesize index=_index;

static const NSUInteger kRadioButtonWidth=22;
static const NSUInteger kRadioButtonHeight=22;

static NSMutableArray *rb_instances=nil;
static NSMutableDictionary *rb_observers=nil;

#pragma mark - Observer

+(void)addObserverForGroupId:(NSString*)groupId observer:(id)observer{
    if(!rb_observers){
        rb_observers = [[NSMutableDictionary alloc] init];
    }
    
    if ([groupId length] > 0 && observer) {
        [rb_observers setObject:observer forKey:groupId];
        // Make it weak reference
        [observer release];
    }
}

#pragma mark - Manage Instances

+(void)registerInstance:(RadioButton*)radioButton{
    if(!rb_instances){
        rb_instances = [[NSMutableArray alloc] init];
    }
    
    [rb_instances addObject:radioButton];
    // Make it weak reference
    [radioButton release];
}

#pragma mark - Class level handler

+(void)buttonSelected:(RadioButton*)radioButton{
    
    // Notify observers
    if (rb_observers) {
        id observer= [rb_observers objectForKey:radioButton.groupId];
        
        if(observer && [observer respondsToSelector:@selector(radioButtonSelectedAtIndex:inGroup:)]){
            [observer radioButtonSelectedAtIndex:radioButton.index inGroup:radioButton.groupId];
        }
    }
    
    // Unselect the other radio buttons
    if (rb_instances) {
        for (int i = 0; i < [rb_instances count]; i++) {
            RadioButton *button = [rb_instances objectAtIndex:i];
            if (![button isEqual:radioButton]) {
                [button otherButtonSelected:radioButton];
            }
        }
    }
}

#pragma mark - Object Lifecycle

-(id)initWithGroupId:(NSString*)groupId index:(NSUInteger)index{
    self = [self init];
    if (self) {
        _groupId = groupId;
        _index = index;
    }
    return  self;
}

- (id)init{
    self = [super init];
    if (self) {
        [self defaultInit];
    }
    return self;
}

- (void)dealloc
{
    [_groupId release];
    [_button release];
    [super dealloc];
}


#pragma mark - Tap handling

-(void)handleButtonTap:(id)sender{
    [_button setSelected:YES];
    [RadioButton buttonSelected:self];
}

-(void)otherButtonSelected:(id)sender{
    // Called when other radio button instance got selected
    if(_button.selected){
        [_button setSelected:NO];        
    }
}

#pragma mark - RadioButton init

-(void)defaultInit{
    // Setup container view
    self.frame = CGRectMake(0, 0, kRadioButtonWidth, kRadioButtonHeight);
    
    // Customize UIButton
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0,kRadioButtonWidth, kRadioButtonHeight);
    _button.adjustsImageWhenHighlighted = NO; 
    
    [_button setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateSelected];
    
    [_button addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_button];
    
    [RadioButton registerInstance:self];
}


@end

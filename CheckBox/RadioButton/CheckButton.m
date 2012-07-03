//
//  CheckButton.m
//  AllApart
//
//  Created by steven yang on 11-1-18.
//  Copyright 2011 kmyhy. All rights reserved.
//

#import "CheckButton.h"


#define CHECKPIC @"checked.png"
#define UNCHECKPIC @"unchecked.png"

@implementation CheckButton
@synthesize label,icon,delegate;


-( id )initWithFrame:( CGRect ) frame Delegate:(id)_delegate
{
    if ( self =[ super initWithFrame : frame ]) {
        
        //icon
        icon =[[ UIImageView alloc ] initWithFrame :CGRectMake ( 10 , 0 , frame . size . height , frame . size . height )];        
        [ self addSubview : icon ];
        
        
        //label
        label =[[ UILabel alloc ] initWithFrame : CGRectMake ( icon . frame . size . width + 24 , 0 ,
                                                              frame . size . width - icon . frame . size . width - 24 ,
                                                              frame . size . height )];
        label . backgroundColor =[ UIColor clearColor ];
        label . font =[ UIFont fontWithName : @"Arial" size : 20 ];
        label . textColor =[ UIColor whiteColor];
        label . textAlignment = UITextAlignmentLeft ;        
        [ self addSubview : label ];
              
        [ self setChecked : checked ];
        self.delegate = _delegate;
        
        [ self addTarget : self action : @selector ( clicked ) forControlEvents : UIControlEventTouchUpInside ];        
      
    }
    return self ;
}


-( BOOL )isChecked{
    return checked ;
}
-( void )setChecked:( BOOL )status{
    if (status!= checked ){
        checked = status;
    }
    if ( checked ) {
        [ icon setImage :[ UIImage imageNamed : CHECKPIC ]];
    } else {
        [ icon setImage :[ UIImage imageNamed : UNCHECKPIC ]];
    }
}
-( void )clicked{
    [ self setChecked :! checked];
    if ( delegate != nil ) {
        SEL sel= NSSelectorFromString ( @"checkButtonClicked:" );
        if ([ delegate respondsToSelector :sel]){
            [delegate performSelector:sel withObject:self];
        } 
    }
}
-( void )dealloc{
    delegate = nil ;
    [ label release ];
    [ icon release ];
    [ super dealloc ];
}
@end

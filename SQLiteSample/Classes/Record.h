//
//  Record.h
//  SQLiteSample
//
//  Created by wang xuefeng on 10-12-29.
//  Copyright 2010 www.5yi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Record : NSObject {
	int index;
	NSString *title;
	NSString *body;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *body;

- (id)initWithIndex:(int)newIndex Title:(NSString *)newTitle Body:(NSString *)newBody;
- (int)getIndex;

@end

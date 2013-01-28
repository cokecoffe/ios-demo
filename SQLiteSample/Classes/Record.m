//
//  Record.m
//  SQLiteSample
//
//  Created by wang xuefeng on 10-12-29.
//  Copyright 2010 www.5yi.com. All rights reserved.
//

#import "Record.h"

@implementation Record

@synthesize title, body;

- (id)initWithIndex:(int)newIndex Title:(NSString *)newTitle Body:(NSString *)newBody{
	if(self = [super init]){
		index = newIndex;
		self.title = newTitle;
		self.body = newBody;
	}
	
	return self;
}

- (int)getIndex{
	return index;
}

- (void)dealloc {
	[title release];
	[body release];
	[super dealloc];
}

@end
//
//  Database.m
//  SQLiteSample
//
//  Created by wang xuefeng on 10-12-29.
//  Copyright 2010 www.5yi.com. All rights reserved.
//

#import "DB.h"

#define DB_NAME @"sample.db"


@implementation DB


- (BOOL)initDatabase
{
	BOOL success;
	NSError *error;
	NSFileManager *fm = [NSFileManager defaultManager];
	NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"sample.db"];
	
	success = [fm fileExistsAtPath:writableDBPath];
	
	if(!success){
		NSString *defaultDBPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"sample.db"];
		NSLog(@"%@",defaultDBPath);
		success = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
		if(!success){
			NSLog(@"error: %@", [error localizedDescription]);
		}
		success = YES;
	}
	
	if(success){
		db = [[FMDatabase databaseWithPath:writableDBPath] retain];
		if ([db open]) {
			[db setShouldCacheStatements:YES];
		}else{
			NSLog(@"Failed to open database.");
			success = NO;
		}
	}
	
	return success;
}


- (void)closeDatabase
{
	[db close];
}


- (FMDatabase *)getDatabase
{
	if ([self initDatabase]){
		return db;
	}
	
	return NULL;
}


- (void)dealloc
{
	[self closeDatabase];
	
	[db release];
	[super dealloc];
}

@end

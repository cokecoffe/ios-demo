//
//  DownLoadHelper.h
//  UseNetWork
//
//  Created by  vistech on 11-10-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DownLoadHelperDelegate <NSObject>
@optional
-(void) didReceiveData:(NSData *)theData;
-(void) didReceiveFilename:(NSString *)aName;
-(void) dataDownloadFailed:(NSString *)reason;
-(void) dataDownloadAtPercent:(NSNumber *)aPercent;

@end


@interface DownLoadHelper : NSObject {
	NSURLResponse *respone;
	NSMutableData *data;
	NSString *urlString;
	NSURLConnection *urlconnection;
	id <DownLoadHelperDelegate> delegate;
	BOOL isDownloading;
	
	NSString *username;
	NSString *userpassword;
}
@property(nonatomic ,retain) NSURLResponse *respone;
@property(nonatomic ,retain) NSMutableData *data;
@property(nonatomic ,retain) NSString *urlString;
@property(nonatomic ,retain) NSURLConnection *urlconnection;
@property(nonatomic ,retain) id delegate;
@property(assign) BOOL isDownloading;
@property(nonatomic ,retain) NSString *username;
@property(nonatomic ,retain) NSString *userpassword;

+(DownLoadHelper *) sharedInstance;
+(void) download:(NSString *)aURLString;
+(void) cancel;
@end

//
//  DownLoadHelper.m
//  UseNetWork
//
//  Created by  vistech on 11-10-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DownLoadHelper.h"

static DownLoadHelper *sharedInstance = nil;
@implementation DownLoadHelper
@synthesize respone;
@synthesize data;
@synthesize urlString;
@synthesize urlconnection;
@synthesize delegate;
@synthesize isDownloading;
@synthesize username,userpassword;

-(void)start{
	self.isDownloading = NO;
	NSURL *url = [NSURL URLWithString:self.urlString];
	if (!url) {

		NSString *reason = [NSString stringWithFormat:@"Could not create URL from string %@",self.urlString];
		if (sharedInstance.delegate && [sharedInstance.delegate respondsToSelector:@selector(dataDownloadFailed:)]) {
			[sharedInstance.delegate performSelector:@selector(dataDownloadFailed:) withObject:reason];
			return;
		}
	}
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	if (!theRequest) {
		NSString *reason = [NSString stringWithFormat:@"Could not create URL request from string %@",self.urlString];
		if (sharedInstance.delegate && [sharedInstance.delegate respondsToSelector:@selector(dataDownloadFailed:)]) {
			[sharedInstance.delegate performSelector:@selector(dataDownloadFailed:) withObject:reason];
			return;
		}
	}
	
	self.urlconnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (!self.urlString) {
		NSString *reason = [NSString stringWithFormat:@"URL connection failed for string %@",self.urlString];
		if (sharedInstance.delegate && [sharedInstance.delegate respondsToSelector:@selector(dataDownloadFailed:)]) {
			[sharedInstance.delegate performSelector:@selector(dataDownloadFailed:) withObject:reason];
			return;
		}
	}
	
	self.isDownloading = YES;
	
	self.data = [NSMutableData data];
	self.respone = nil;
	[self.urlconnection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
	if (!username || !userpassword) {
		[[challenge sender] useCredential:nil forAuthenticationChallenge:challenge];
		return;
	}
	NSURLCredential *cred = [[[NSURLCredential alloc] initWithUser:self.username password:self.userpassword persistence:NSURLCredentialPersistenceNone] autorelease];
	[[challenge sender] useCredential:cred forAuthenticationChallenge:challenge];
}

-(void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
	NSLog(@"Challenge cancelled");
}

-(void)cleanup{
	self.data = nil;
	self.respone = nil;
	self.urlconnection = nil;
	self.urlString = nil;
	self.isDownloading = NO;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aresponse{
	self.respone = aresponse;
	if ([aresponse expectedContentLength] < 0) {
		NSString *reason = [NSString stringWithFormat:@"Invalid URL [%@]",self.urlString];
		if (sharedInstance.delegate && [sharedInstance.delegate respondsToSelector:@selector(dataDownloadFailed:)]) {
			[sharedInstance.delegate performSelector:@selector(dataDownloadFailed:) withObject:reason];
		}
		[connection cancel];
		[self cleanup];
		return;
	}
	
	if ([aresponse suggestedFilename]) {
		if (sharedInstance.delegate && [sharedInstance.delegate respondsToSelector:@selector(didReceiveFilename:)]) {
			[sharedInstance.delegate performSelector:@selector(didReceiveFilename:) withObject:[aresponse suggestedFilename]];
		}
	}
	
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData{
	[self.data appendData:theData];
	if (self.respone) {
		float exectedlength = [self.respone expectedContentLength];
		float currentLength = self.data.length;
		float percent = currentLength / exectedlength;
		if (sharedInstance.delegate && [sharedInstance.delegate respondsToSelector:@selector(dataDownloadAtPercent:)]) {
			[sharedInstance.delegate performSelector:@selector(dataDownloadAtPercent:) withObject:[NSNumber numberWithFloat:percent]];
		}
	}
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	self.respone = nil;
	if (self.delegate) {
		NSData *theData = [self.data retain];
		if (sharedInstance.delegate && [sharedInstance.delegate respondsToSelector:@selector(didReceiveData:)]) {
			[sharedInstance.delegate performSelector:@selector(didReceiveData:) withObject:theData];
		}
	}
	[self.urlconnection unscheduleFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	[self cleanup];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	self.isDownloading = NO;
	NSLog(@"Error:failed connection ,%@",[error localizedDescription]);
	if (sharedInstance.delegate && [sharedInstance.delegate respondsToSelector:@selector(dataDownloadFailed:)]) {
		[sharedInstance.delegate performSelector:@selector(dataDownloadFailed:) withObject:@"Failed Connection"];
	}
	[self cleanup];
}

+(DownLoadHelper *)sharedInstance{
	if (!sharedInstance) {
		sharedInstance = [[self alloc] init];
	}
	return sharedInstance;
}

+(void)download:(NSString *)aURLString{
	if (sharedInstance.isDownloading) {
		NSLog(@"Error:Cannot start new download until current download finishes");
		if (sharedInstance.delegate && [sharedInstance.delegate respondsToSelector:@selector(didReceiveData:)]) {
			[sharedInstance.delegate performSelector:@selector(didReceiveData:) withObject:@""];
		}
		return;
	}
	
	sharedInstance.urlString = aURLString;
	[sharedInstance start];
}

+(void)cancel{
	if (sharedInstance.isDownloading) {
		[sharedInstance.urlconnection cancel];
	}
}

@end

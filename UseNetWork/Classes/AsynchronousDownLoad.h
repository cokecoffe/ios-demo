//
//  AsynchronousDownLoad.h
//  UseNetWork
//
//  Created by  vistech on 11-10-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DownLoadHelper.h"

@interface AsynchronousDownLoad : UIViewController {
	NSMutableString *log;
	IBOutlet UITextView *textView;
	IBOutlet UIProgressView *progress;
	NSString *savePath;
}
@property(nonatomic ,retain) NSMutableString *log;
@property(nonatomic ,retain) UITextView *textView;
@property(nonatomic ,retain) UIProgressView *progress;
@property(nonatomic ,retain) NSString *savePath;

@end

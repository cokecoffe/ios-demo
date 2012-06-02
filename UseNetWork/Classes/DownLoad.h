//
//  DownLoad.h
//  UseNetWork
//
//  Created by  vistech on 11-10-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<MediaPlayer/MediaPlayer.h>

@interface DownLoad : UIViewController {
	NSMutableString *log;
	IBOutlet UITextView *textView;
	NSString *savePath;
}
@property(nonatomic ,retain)NSMutableString *log;
@property(nonatomic ,retain)UITextView *textView;
@property(nonatomic ,retain)NSString *savepath;
@end

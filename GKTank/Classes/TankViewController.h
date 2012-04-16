/*
 
 ===== IMPORTANT =====
 
 This is sample code demonstrating API, technology or techniques in development.
 Although this sample code has been reviewed for technical accuracy, it is not
 final. Apple is supplying this information to help you plan for the adoption of
 the technologies and programming interfaces described herein. This information
 is subject to change, and software implemented based on this sample code should
 be tested with final operating system software and final documentation. Newer
 versions of this sample code may be provided with future seeds of the API or
 technology. For information about updates to this and other developer
 documentation, view the New & Updated sidebars in subsequent documentation
 seeds.
 
 =====================
 
 File: TankViewController.h
 Abstract: A simple game showing off the features of GameKit.
 
 Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple Inc.
 ("Apple") in consideration of your agreement to the following terms, and your
 use, installation, modification or redistribution of this Apple software
 constitutes acceptance of these terms.  If you do not agree with these terms,
 please do not use, install, modify or redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and subject
 to these terms, Apple grants you a personal, non-exclusive license, under
 Apple's copyrights in this original Apple software (the "Apple Software"), to
 use, reproduce, modify and redistribute the Apple Software, with or without
 modifications, in source and/or binary forms; provided that if you redistribute
 the Apple Software in its entirety and without modifications, you must retain
 this notice and the following text and disclaimers in all such redistributions
 of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may be used
 to endorse or promote products derived from the Apple Software without specific
 prior written permission from Apple.  Except as expressly stated in this notice,
 no other rights or licenses, express or implied, are granted by Apple herein,
 including but not limited to any patent rights that may be infringed by your
 derivative works or by other works in which the Apple Software may be
 incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
 WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
 WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
 COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR
 DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF
 CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF
 APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2009 Apple Inc. All Rights Reserved.
 
 */

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

#define NUMWALLS	32

typedef enum {
	BLOCK_VERTICAL,
	BLOCK_HORIZONTAL
} levelBlockType;

typedef enum {
	NETWORK_ACK,					// no packet
	NETWORK_COINTOSS,				// decide who is going to be the server
	NETWORK_MOVE_EVENT,				// send position
	NETWORK_FIRE_EVENT,				// send fire
	NETWORK_HEARTBEAT				// send of entire state at regular intervals
} packetCodes;

typedef struct {
	CGPoint		tankPreviousPosition;
	CGPoint		tankPosition;
	CGPoint		tankMissilePosition;
	CGPoint		tankDestination;
	
	float		tankRotation;
	float		tankDirection;
	float		tankMissileDirection;
	int			tankMissile;
} tankInfo;

@interface TankViewController : UIViewController <GKPeerPickerControllerDelegate, GKSessionDelegate, UIAlertViewDelegate> {
	IBOutlet	UIImageView		*tank1;
	IBOutlet	UIImageView		*tank2;
	IBOutlet	UIImageView		*missile1;
	IBOutlet	UIImageView		*missile2;
	
	IBOutlet	UILabel			*gameLabel;
	IBOutlet	UILabel			*score1;
	IBOutlet	UILabel			*score2;

	UIImageView	*walls[NUMWALLS];
	
	UIImage		*levelBlockV;
	UIImage		*levelBlockH;
	
	CGPoint		tank1Start;
	CGPoint		tank2Start;
	tankInfo	tankStats[2];
	
	int			levelBlocks;
	int			playerScore1, playerScore2;
	
	NSInteger	gameState;
	NSInteger	peerStatus;
	
	// networking
	GKSession		*gameSession;
	int				gameUniqueID;
	int				gamePacketNumber;
	NSString		*gamePeerId;
	NSDate			*lastHeartbeatDate;
	
	UIAlertView		*connectionAlert;
}

@property(nonatomic, retain) IBOutlet UIImageView	*tank1;
@property(nonatomic, retain) IBOutlet UIImageView	*tank2;
@property(nonatomic, retain) IBOutlet UIImageView	*missile1;
@property(nonatomic, retain) IBOutlet UIImageView	*missile2;
@property(nonatomic, retain) IBOutlet UILabel		*gameLabel;
@property(nonatomic, retain) IBOutlet UILabel		*score1;
@property(nonatomic, retain) IBOutlet UILabel		*score2;
@property(nonatomic, retain) UIImage *levelBlockV;
@property(nonatomic, retain) UIImage *levelBlockH;

@property(nonatomic) NSInteger		gameState;
@property(nonatomic) NSInteger		peerStatus;

@property(nonatomic, retain) GKSession	 *gameSession;
@property(nonatomic, copy)	 NSString	 *gamePeerId;
@property(nonatomic, retain) NSDate		 *lastHeartbeatDate;
@property(nonatomic, retain) UIAlertView *connectionAlert;

- (void)invalidateSession:(GKSession *)session;

- (void)playerReset;
- (void)updateTanks;
- (void)gameLoop;
- (void)addToLevel:(levelBlockType)bType atX:(float)x atY:(float)y width:(float)w height:(float)h;
- (void)sendNetworkPacket:(GKSession *)session packetID:(int)packetID withData:(void *)data ofLength:(int)length reliable:(BOOL)howtosend;
- (BOOL)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error;

@end


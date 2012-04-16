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
 
 File: TankViewController.m
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

#import "TankViewController.h"

//
// various states the game can get into
//
typedef enum {
	kStateStartGame,
	kStatePicker,
	kStateMultiplayer,
	kStateMultiplayerCointoss,
	kStateMultiplayerReconnect
} gameStates;

//
// for the sake of simplicity tank1 is the server and tank2 is the client
//
typedef enum {
	kServer,
	kClient
} gameNetwork;

// the cool "completely change the game" variables
const float kTankSpeed = 1.0f;
const float kMissileSpeed = 3.0f;
const float kTankTurnSpeed = 0.1f;
const float kHeartbeatTimeMaxDelay = 2.0f;
#define missileLife 60

// strings for game label
#define kStartLabel	@"Tap to Start"
#define kBlueLabel	@"You're Blue"
#define kRedLabel	@"You're Red"

// GameKit Session ID for app
#define kTankSessionID @"gktank"

#define kMaxTankPacketSize 1024

#pragma mark -
@implementation TankViewController

#pragma mark View Controller Related Methods

@synthesize tank1, tank2, missile1, missile2, gameState, peerStatus, gameLabel, levelBlockV, levelBlockH, score1, score2, gameSession, gamePeerId, lastHeartbeatDate, connectionAlert;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	peerStatus = kServer;
	gamePacketNumber = 0;
	gameSession = nil;
	gamePeerId = nil;
	lastHeartbeatDate = nil;
		
	NSString *uid = [[UIDevice currentDevice] uniqueIdentifier];
	
	levelBlocks = 0;
	gameUniqueID = [uid hash];
	
	NSError *parseError = nil;
	NSBundle *bundle = [NSBundle mainBundle];
	levelBlockH = [UIImage imageNamed:@"blockh.png"];
	levelBlockV = [UIImage imageNamed:@"blockv.png"];
	
	[self parseXMLFileAtURL:[NSURL fileURLWithPath: [bundle pathForResource:@"level1" ofType:@"xml"]] parseError:&parseError];
		
	self.gameState = kStateStartGame; // Setting to kStateStartGame does a reset of players, scores, etc. See -setGameState: below
	
	[NSTimer scheduledTimerWithTimeInterval:0.033 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc { 
	self.tank1 = nil;
	self.tank2 = nil;
	self.missile1 = nil;
	self.missile2 = nil;
	self.gameLabel = nil;
	self.score1 = nil;
	self.score2 = nil;
	self.lastHeartbeatDate = nil;
	if(self.connectionAlert.visible) {
		[self.connectionAlert dismissWithClickedButtonIndex:-1 animated:NO];
	}
	self.connectionAlert = nil;
	
	// release each of the walls
	for(int i=0; i<levelBlocks;i++) {
		[walls[i] release];
		walls[i] = nil; 
	}
	levelBlocks = 0;
	
	self.levelBlockV = nil;
	self.levelBlockH = nil;
	
	// cleanup the session
	[self invalidateSession:self.gameSession];
	self.gameSession = nil;
	self.gamePeerId = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Peer Picker Related Methods

-(void)startPicker {
	GKPeerPickerController*		picker;
	
	self.gameState = kStatePicker;			// we're going to do Multiplayer!
	
	picker = [[GKPeerPickerController alloc] init]; // note: picker is released in various picker delegate methods when picker use is done.
	picker.delegate = self;
	[picker show]; // show the Peer Picker
}

#pragma mark GKPeerPickerControllerDelegate Methods

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker { 
	// Peer Picker automatically dismisses on user cancel. No need to programmatically dismiss.
    
	// autorelease the picker. 
	picker.delegate = nil;
    [picker autorelease]; 
	
	// invalidate and release game session if one is around.
	if(self.gameSession != nil)	{
		[self invalidateSession:self.gameSession];
		self.gameSession = nil;
	}
	
	// go back to start mode
	self.gameState = kStateStartGame;
} 

/*
 *	Note: No need to implement -peerPickerController:didSelectConnectionType: delegate method since this app does not support multiple connection types.
 *		- see reference documentation for this delegate method and the GKPeerPickerController's connectionTypesMask property.
 */

//
// Provide a custom session that has a custom session ID. This is also an opportunity to provide a session with a custom display name.
//
- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type { 
	GKSession *session = [[GKSession alloc] initWithSessionID:kTankSessionID displayName:nil sessionMode:GKSessionModePeer]; 
	return [session autorelease]; // peer picker retains a reference, so autorelease ours so we don't leak.
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session { 
	// Remember the current peer.
	self.gamePeerId = peerID;  // copy
	
	// Make sure we have a reference to the game session and it is set up
	self.gameSession = session; // retain
	self.gameSession.delegate = self; 
	[self.gameSession setDataReceiveHandler:self withContext:NULL];
	
	// Done with the Peer Picker so dismiss it.
	[picker dismiss];
	picker.delegate = nil;
	[picker autorelease];
	
	// Start Multiplayer game by entering a cointoss state to determine who is server/client.
	self.gameState = kStateMultiplayerCointoss;
} 

#pragma mark -
#pragma mark Session Related Methods

//
// invalidate session
//
- (void)invalidateSession:(GKSession *)session {
	if(session != nil) {
		[session disconnectFromAllPeers]; 
		session.available = NO; 
		[session setDataReceiveHandler: nil withContext: NULL]; 
		session.delegate = nil; 
	}
}

#pragma mark Data Send/Receive Methods

/*
 * Getting a data packet. This is the data receive handler method expected by the GKSession. 
 * We set ourselves as the receive data handler in the -peerPickerController:didConnectPeer:toSession: method.
 */
- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context { 
	static int lastPacketTime = -1;
	unsigned char *incomingPacket = (unsigned char *)[data bytes];
	int *pIntData = (int *)&incomingPacket[0];
	//
	// developer  check the network time and make sure packers are in order
	//
	int packetTime = pIntData[0];
	int packetID = pIntData[1];
	if(packetTime < lastPacketTime && packetID != NETWORK_COINTOSS) {
		return;	
	}
	
	lastPacketTime = packetTime;
	switch( packetID ) {
		case NETWORK_COINTOSS:
			{
				// coin toss to determine roles of the two players
				int coinToss = pIntData[2];
				// if other player's coin is higher than ours then that player is the server
				if(coinToss > gameUniqueID) {
					self.peerStatus = kClient;
				}
				
				// notify user of tank color
				self.gameLabel.text = (self.peerStatus == kServer) ? kBlueLabel : kRedLabel; // server is the blue tank, client is red
				self.gameLabel.hidden = NO;
				// after 1 second fire method to hide the label
				[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideGameLabel:) userInfo:nil repeats:NO];
			}
			break;
		case NETWORK_MOVE_EVENT:
			{
				// received move event from other player, update other player's position/destination info
				tankInfo *ts = (tankInfo *)&incomingPacket[8];
				int peer = (self.peerStatus == kServer) ? kClient : kServer;
				tankInfo *ds = &tankStats[peer];
				ds->tankDestination = ts->tankDestination;
				ds->tankDirection = ts->tankDirection;
			}
			break;
		case NETWORK_FIRE_EVENT:
			{
				// received a missile fire event from other player, update other player's firing status
				tankInfo *ts = (tankInfo *)&incomingPacket[8];
				int peer = (self.peerStatus == kServer) ? kClient : kServer;
				tankInfo *ds = &tankStats[peer];
				ds->tankMissile = ts->tankMissile;
				ds->tankMissilePosition = ts->tankMissilePosition;
				ds->tankMissileDirection = ts->tankMissileDirection;
			}
			break;
		case NETWORK_HEARTBEAT:
			{
				// Received heartbeat data with other player's position, destination, and firing status.
				
				// update the other player's info from the heartbeat
				tankInfo *ts = (tankInfo *)&incomingPacket[8];		// tank data as seen on other client
				int peer = (self.peerStatus == kServer) ? kClient : kServer;
				tankInfo *ds = &tankStats[peer];					// same tank, as we see it on this client
				memcpy( ds, ts, sizeof(tankInfo) );
				
				// update heartbeat timestamp
				self.lastHeartbeatDate = [NSDate date];
				
				// if we were trying to reconnect, set the state back to multiplayer as the peer is back
				if(self.gameState == kStateMultiplayerReconnect) {
					if(self.connectionAlert && self.connectionAlert.visible) {
						[self.connectionAlert dismissWithClickedButtonIndex:-1 animated:YES];
					}
					self.gameState = kStateMultiplayer;
				}
			}
			break;
		default:
			// error
			break;
	}
}

- (void)sendNetworkPacket:(GKSession *)session packetID:(int)packetID withData:(void *)data ofLength:(int)length reliable:(BOOL)howtosend {
	// the packet we'll send is resued
	static unsigned char networkPacket[kMaxTankPacketSize];
	const unsigned int packetHeaderSize = 2 * sizeof(int); // we have two "ints" for our header
	
	if(length < (kMaxTankPacketSize - packetHeaderSize)) { // our networkPacket buffer size minus the size of the header info
		int *pIntData = (int *)&networkPacket[0];
		// header info
		pIntData[0] = gamePacketNumber++;
		pIntData[1] = packetID;
		// copy data in after the header
		memcpy( &networkPacket[packetHeaderSize], data, length ); 
		
		NSData *packet = [NSData dataWithBytes: networkPacket length: (length+8)];
		if(howtosend == YES) { 
			[session sendData:packet toPeers:[NSArray arrayWithObject:gamePeerId] withDataMode:GKSendDataReliable error:nil];
		} else {
			[session sendData:packet toPeers:[NSArray arrayWithObject:gamePeerId] withDataMode:GKSendDataUnreliable error:nil];
		}
	}
}

#pragma mark GKSessionDelegate Methods

// we've gotten a state change in the session
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state { 
	if(self.gameState == kStatePicker) {
		return;				// only do stuff if we're in multiplayer, otherwise it is probably for Picker
	}
	
	if(state == GKPeerStateDisconnected) {
		// We've been disconnected from the other peer.
		
		// Update user alert or throw alert if it isn't already up
		NSString *message = [NSString stringWithFormat:@"Could not reconnect with %@.", [session displayNameForPeer:peerID]];
		if((self.gameState == kStateMultiplayerReconnect) && self.connectionAlert && self.connectionAlert.visible) {
			self.connectionAlert.message = message;
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lost Connection" message:message delegate:self cancelButtonTitle:@"End Game" otherButtonTitles:nil];
			self.connectionAlert = alert;
			[alert show];
			[alert release];
		}
		
		// go back to start mode
		self.gameState = kStateStartGame; 
	} 
} 

#pragma mark -
#pragma mark Game Logic Methods

//
// setter for gameState property
//
- (void)setGameState:(NSInteger)newState {
	if(newState == kStateStartGame) {
		if(self.gameSession) {
			// invalidate session and release it.
			[self invalidateSession:self.gameSession];
			self.gameSession = nil;
		}
		
		// reset players to initial positions
		[self playerReset];
		
		// reset scores
		playerScore1 = 0;
		playerScore2 = 0;
		self.score1.text = @"0";
		self.score2.text = @"0";
		
		// show start label
		self.gameLabel.text = kStartLabel;
		self.gameLabel.hidden = NO;
	}
	
	gameState = newState;
}

//
// Called by NSTimer fire, hides the game label
//
- (void)hideGameLabel:(NSTimer *)timer {
	if(self.gameLabel) {
		self.gameLabel.hidden = YES;
	}
}

//
// Put players in starting position
//
- (void)playerReset {
	
	tank1.center = tank1Start;
	tank2.center = tank2Start;
	
	tankStats[0].tankPosition = tankStats[0].tankMissilePosition = tankStats[0].tankPreviousPosition = tankStats[0].tankDestination = tank1.center;
	tankStats[1].tankPosition = tankStats[1].tankMissilePosition = tankStats[1].tankPreviousPosition = tankStats[1].tankDestination = tank2.center;
	tankStats[0].tankRotation = tankStats[0].tankMissileDirection = tankStats[0].tankDirection = M_PI;
	tankStats[1].tankRotation = tankStats[1].tankMissileDirection = tankStats[1].tankDirection = 0.0f;
	tankStats[0].tankMissile = tankStats[1].tankMissile = 0;
	missile1.hidden = YES;
	missile2.hidden = YES;
	
	tank1.transform = CGAffineTransformMakeRotation(tankStats[0].tankRotation);
	tank2.transform = CGAffineTransformMakeRotation(tankStats[1].tankRotation);
	
	self.lastHeartbeatDate = nil;
}

//
// Game loop runs at regular interval to update game based on current game state
//
- (void)gameLoop {
	static int counter = 0;
	switch (self.gameState) {
		case kStatePicker:
		case kStateStartGame:
			break;
		case kStateMultiplayerCointoss:
			[self sendNetworkPacket:self.gameSession packetID:NETWORK_COINTOSS withData:&gameUniqueID ofLength:sizeof(int) reliable:YES];
			self.gameState = kStateMultiplayer; // we only want to be in the cointoss state for one loop
			break;
		case kStateMultiplayer:
			[self updateTanks];
			counter++;
			if(!(counter&7)) { // once every 8 updates check if we have a recent heartbeat from the other player, and send a heartbeat packet with current state
				if(self.lastHeartbeatDate == nil) {
					// we haven't received a hearbeat yet, so set one (in case we never receive a single heartbeat)
					self.lastHeartbeatDate = [NSDate date];
				}
				else if(fabs([self.lastHeartbeatDate timeIntervalSinceNow]) >= kHeartbeatTimeMaxDelay) { // see if the last heartbeat is too old
					// seems we've lost connection, notify user that we are trying to reconnect (until GKSession actually disconnects)
					NSString *message = [NSString stringWithFormat:@"Trying to reconnect...\nMake sure you are within range of %@.", [self.gameSession displayNameForPeer:self.gamePeerId]];
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lost Connection" message:message delegate:self cancelButtonTitle:@"End Game" otherButtonTitles:nil];
					self.connectionAlert = alert;
					[alert show];
					[alert release];
					self.gameState = kStateMultiplayerReconnect;
				}
				
				// send a new heartbeat to other player
				tankInfo *ts = &tankStats[self.peerStatus];
				[self sendNetworkPacket:gameSession packetID:NETWORK_HEARTBEAT withData:ts ofLength:sizeof(tankInfo) reliable:NO];
			}
			break;
		case kStateMultiplayerReconnect:
			// we have lost a heartbeat for too long, so pause game and notify user while we wait for next heartbeat or session disconnect.
			counter++;
			if(!(counter&7)) { // keep sending heartbeats to the other player in case it returns
				tankInfo *ts = &tankStats[self.peerStatus];
				[self sendNetworkPacket:gameSession packetID:NETWORK_HEARTBEAT withData:ts ofLength:sizeof(tankInfo) reliable:NO];
			}
			break;
		default:
			break;
	}
}

//
// rotate and move the tanks towards their destinations if need be
//
- (void)updateTanks {
	int i;
	for(i=0;i<2;i++) {
		UIImageView	*theTank;
		UIImageView *enemyTank;
		UIImageView *theMissile;
		tankInfo *ts = &tankStats[i];
		
		if(i==0) {
			theTank = tank1;
			enemyTank = tank2;
			theMissile = missile1;
		} else {
			theTank = tank2;
			enemyTank = tank1;
			theMissile = missile2;
		}
		
		bool checkCollision = true;
		
		if( (fabs(ts->tankPosition.x - ts->tankDestination.x)>kTankSpeed) || (fabs(ts->tankPosition.y - ts->tankDestination.y)>kTankSpeed) ) {
			// check facing
			float ad = ts->tankDirection - ts->tankRotation;
			
			if(fabs(ad) > kTankTurnSpeed) {
				// we need to turn, work out which way (find the closest 180)
				while(ad > M_PI) {
					ad -= (2.0 * M_PI);
				}
				while(ad < -M_PI) {
					ad += (2.0 * M_PI);
				}
				if(ad < 0) {
					ts->tankRotation -= kTankTurnSpeed;
					if(ts->tankRotation < 0)
						ts->tankRotation += (2.0*M_PI);
				} else if(ad > 0) {
					ts->tankRotation += kTankTurnSpeed;
					if(ts->tankRotation > (2.0*M_PI))
						ts->tankRotation -= (2.0*M_PI);
				}
				checkCollision = false;
			} else {
				ts->tankRotation = ts->tankDirection;
				// if facing move along line towards destination
				float dx = ts->tankPosition.x - ts->tankDestination.x;
				float dy = ts->tankPosition.y - ts->tankDestination.y;
				float at = atan2( dy, dx );
				// 1.0 is the "speed"
				ts->tankPosition.x -= kTankSpeed * cos(at);
				ts->tankPosition.y -= kTankSpeed * sin(at);
			}
		} else {
			ts->tankPosition.x = ts->tankDestination.x;
			ts->tankPosition.y = ts->tankDestination.y;
		}
		bool collide = false;
		// if we're not rotating we can check for collisions
		if(checkCollision) {
			// check for collisions
			CGRect tankframe = CGRectInset(theTank.frame, theTank.frame.size.width/4.0, theTank.frame.size.height/4.0); // make a collision frame that's half the size and centered to the actual tank image
			
			for(int j=0; j<levelBlocks; j++) {
				// see if we're hitting anything
				if(CGRectIntersectsRect(tankframe, walls[j].frame)) {
					ts->tankPosition = ts->tankPreviousPosition;
					ts->tankDestination = ts->tankPosition;
					collide = true;
					break;
				}
			}
		}
		if(!collide) {
			ts->tankPreviousPosition = theTank.center;
			theTank.center = ts->tankPosition;
			theTank.transform = CGAffineTransformMakeRotation(ts->tankRotation);
		}
		// see if we've fired something
		if(ts->tankMissile != 0) {
			ts->tankMissile--;
			if(ts->tankMissile == 0) {
				theMissile.hidden = YES;
			} else {
				theMissile.hidden = NO;
				ts->tankMissilePosition.x -= kMissileSpeed * cos(ts->tankMissileDirection); 
				ts->tankMissilePosition.y -= kMissileSpeed * sin(ts->tankMissileDirection);
				theMissile.center = ts->tankMissilePosition;
			}
			
			for(int j=0; j<levelBlocks; j++) {
				// see if we're hitting anything
				if(CGRectIntersectsRect(theMissile.frame, walls[j].frame)) {
					theMissile.hidden = YES;
					ts->tankMissile = 0;
					break;
				}
			}
			
			// check against the other tank
			if(CGRectIntersectsRect(theMissile.frame, enemyTank.frame)) {
				// we hit!
				if(i==0) {
					playerScore1 += 1; // playerScore1 is blue tanks score
					[score1 setText: [NSString stringWithFormat:@"%d", playerScore1]];
				} else {
					playerScore2 += 1; // playerScore2 is red tanks score
					[score2 setText: [NSString stringWithFormat:@"%d", playerScore2]];
				}
				[self playerReset];
				break;
			}
		}
	}
}

#pragma mark -
#pragma mark Event Handling Methods

//
// someone touched the screen
//
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	switch (self.gameState) {
		case kStateStartGame:
			[self startPicker];
			self.gameLabel.hidden = YES;
			break;
		case kStateMultiplayer:
			{
				CGPoint thumbPoint;
				UITouch *thumb = [[event allTouches] anyObject];
				thumbPoint = [thumb locationInView:thumb.view];
				tankInfo *ts = &tankStats[self.peerStatus];
				// hold to move, second finger to fire
				if(thumb.tapCount==0) {
					ts->tankDestination = thumbPoint;
					ts->tankDirection = atan2( thumbPoint.y - ts->tankPosition.y, thumbPoint.x - ts->tankPosition.x ) + (M_PI/2.0);
					// keep us 0-359
					if(ts->tankDirection < 0)
						ts->tankDirection += (2.0*M_PI);
					else if(ts->tankDirection > (2.0*M_PI))
						ts->tankDirection -= (2.0*M_PI);
					if(self.gameState == kStateMultiplayer) {
						[self sendNetworkPacket:gameSession packetID:NETWORK_MOVE_EVENT withData:ts ofLength:sizeof(tankInfo) reliable: NO];
					}
				} else {
					// make sure we're not shooting
					if(ts->tankMissile == 0) {
						ts->tankMissile = missileLife;
						ts->tankMissileDirection = ts->tankRotation + (M_PI/2.0);
						ts->tankMissilePosition = ts->tankPosition;
					}
					if(self.gameState == kStateMultiplayer) {
						[self sendNetworkPacket:gameSession packetID:NETWORK_FIRE_EVENT withData:ts ofLength:sizeof(tankInfo) reliable: NO];
					}
				}
			}
			break;
		default:
			break;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	switch (self.gameState) {
		case kStateStartGame:
			break;
		case kStateMultiplayer:			
			if([touches count] == 1) {
				CGPoint thumbPoint;
				UITouch *thumb = [[event allTouches] anyObject];
				thumbPoint = [thumb locationInView:thumb.view];
				tankInfo *ts = &tankStats[self.peerStatus];
				ts->tankDestination = thumbPoint;
				ts->tankDirection = atan2( thumbPoint.y - ts->tankPosition.y, thumbPoint.x - ts->tankPosition.x ) + (M_PI/2.0);
				// keep us 0-359
				if(ts->tankDirection < 0)
					ts->tankDirection += (2.0*M_PI);
				else if(ts->tankDirection > (2.0*M_PI))
					ts->tankDirection -= (2.0*M_PI);
				if(self.gameState == kStateMultiplayer) {
					[self sendNetworkPacket:gameSession packetID:NETWORK_MOVE_EVENT withData:ts ofLength:sizeof(tankInfo) reliable: NO];
				}
			}
			break;
		default:
			break;
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	switch (self.gameState) {
		case kStateStartGame:
			break;
		case kStateMultiplayer:
			if([touches count] == [[event touchesForView:self.view] count]) {
				tankInfo *ts = &tankStats[self.peerStatus];
				ts->tankDestination = ts->tankPosition;
				ts->tankDirection = ts->tankRotation;
				if(self.gameState == kStateMultiplayer) {
					[self sendNetworkPacket:gameSession packetID:NETWORK_MOVE_EVENT withData:ts ofLength:sizeof(tankInfo) reliable: NO];
				}
			}
			break;
		default:
			break;
	}
}

#pragma mark -
#pragma mark Level Loading Methods
//
// add something to the game level from the level XML file
//
-(void)addToLevel:(levelBlockType) bType atX:(float) x atY:(float) y width:(float)w height:(float)h {
	CGRect box;
	
	box = CGRectMake( x,y, w,h );
	
	if(levelBlocks<NUMWALLS) {
		switch (bType) {
			case BLOCK_VERTICAL:
				walls[levelBlocks] = [[UIImageView alloc] initWithImage: levelBlockV];
				walls[levelBlocks].frame = box;
				walls[levelBlocks].hidden = NO;
				[self.view addSubview: walls[levelBlocks]];
				break;
			case BLOCK_HORIZONTAL:
				walls[levelBlocks] = [[UIImageView alloc] initWithImage: levelBlockH];
				walls[levelBlocks].frame = box;
				walls[levelBlocks].hidden = NO;
				[self.view addSubview: walls[levelBlocks]];
				break;
			default:
				break;
		}
		levelBlocks++;
	}
}

//
// load a game level
//
-(BOOL)parseXMLFileAtURL:(NSURL *)file parseError:(NSError **)error {
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:file];
	// we'll do the parsing
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	
	NSError *parseError = [parser parserError];
	if(parseError && error) {
		*error = parseError;
	}
	
	[parser release];
	
	return (parseError) ? YES : NO; 
}

//
// the XML parser calls here with all the elements for the level
//
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	if(qName) {
		elementName = qName;
	}
	
	if([elementName isEqualToString:@"vblock"]) {
		float x = [[attributeDict valueForKey:@"x"] floatValue];
		float y = [[attributeDict valueForKey:@"y"] floatValue];
		[self addToLevel: BLOCK_VERTICAL atX: x atY: y width: 8 height: 32];
	} 
	else if([elementName isEqualToString:@"hblock"]) {
		float x = [[attributeDict valueForKey:@"x"] floatValue];
		float y = [[attributeDict valueForKey:@"y"] floatValue];
		[self addToLevel: BLOCK_HORIZONTAL atX: x atY: y width: 64 height: 8];
	} 
	else if([elementName isEqualToString:@"player1"]) {
		tank1Start.x = [[attributeDict valueForKey:@"x"] floatValue];
		tank1Start.y = [[attributeDict valueForKey:@"y"] floatValue];
	} 
	else if([elementName isEqualToString:@"player2"]) {
		tank2Start.x = [[attributeDict valueForKey:@"x"] floatValue];
		tank2Start.y = [[attributeDict valueForKey:@"y"] floatValue];
	}
}

//
// the level did not load, file not found, etc.
//
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
	NSLog(@"Error on XML Parse: %@", [parseError localizedDescription] );
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods

// Called when an alert button is tapped.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	// 0 index is "End Game" button
	if(buttonIndex == 0) {
		self.gameState = kStateStartGame; 
	}
}

@end

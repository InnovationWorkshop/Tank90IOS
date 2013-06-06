//
//  HelloWorldLayer.m
//  Tank90
//
//  Created by Nullin on 13-5-28.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"


// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
   
   
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {

        // 获取纹理贴图集的2D贴图
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"tank.png"];
        [frameCache addSpriteFramesWithFile:@"tank.plist"];
        float buttonRadius = 50;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];

        tankLeft = [[CCSprite alloc] initWithSpriteFrameName:@"tank_left.png"];
        tankRight = [[CCSprite alloc] initWithSpriteFrameName:@"tank_right.png"];
        tankUp = [[CCSprite alloc] initWithSpriteFrameName:@"tank_up.png"];
        tankDown = [[CCSprite alloc] initWithSpriteFrameName:@"tank_down.png"];
		
        tankLeft.position = CGPointMake(screenSize.width *.5, screenSize.height *.5);
        tankRight.position = CGPointMake(screenSize.width *.5, screenSize.height *.5);
        tankUp.position = CGPointMake(screenSize.width *.5, screenSize.height *.5);
        tankDown.position = CGPointMake(screenSize.width *.5, screenSize.height *.5);
        
        
        btnFire = [[[SneakyButton alloc] init] autorelease];
        btnFire.isHoldable = YES;
        SneakyButtonSkinnedBase *btnSkinFire = [[SneakyButtonSkinnedBase alloc] init];
        btnSkinFire.position = CGPointMake(screenSize.width - buttonRadius * 3, buttonRadius * 3);
        btnSkinFire.defaultSprite = [CCSprite spriteWithSpriteFrameName:@"pad_center_normal.png"];
        btnSkinFire.activatedSprite = [CCSprite spriteWithSpriteFrameName:@"pad_center_active.png"];
        btnSkinFire.button = btnFire;
        
        float stickRadius = 50;

        btnJoystick = [[SneakyJoystick alloc] initWithRect:CGRectMake(0, 0, stickRadius, stickRadius)];
        btnJoystick.autoCenter = YES;
        btnJoystick.hasDeadzone = YES;
        btnJoystick.isDPad = YES;
        btnJoystick.numberOfDirections = 4;
        btnJoystick.deadRadius = 10;
        SneakyJoystickSkinnedBase* skinStick = [[SneakyJoystickSkinnedBase alloc] init];
        skinStick.position = CGPointMake(stickRadius*3, stickRadius*3);
        skinStick.backgroundSprite = [CCSprite spriteWithSpriteFrameName:@"pad_margin_active.png"];
        skinStick.backgroundSprite.color = ccMAGENTA;
        skinStick.thumbSprite = [CCSprite spriteWithSpriteFrameName:@"pad_center_normal.png"];
        skinStick.thumbSprite.scale = 1.0f;
        skinStick.joystick = btnJoystick;
        [self addChild:skinStick];
        [self addChild:btnSkinFire];
        [self addChild:tankLeft];
        [self addChild:tankRight];
        [self addChild:tankUp];
        [self addChild:tankDown];
        [self scheduleUpdate];
        
        
	}
	return self;
}
-(void)update:(ccTime)delta{
    
    CGPoint velocity = ccpMult(btnJoystick.velocity, 200);
	if (velocity.x != 0 && velocity.y != 0)
	{
		tankLeft.position = CGPointMake(tankLeft.position.x + velocity.x * delta, tankLeft.position.y + velocity.y * delta);
		tankRight.position = CGPointMake(tankLeft.position.x + velocity.x * delta, tankLeft.position.y + velocity.y * delta);
		tankUp.position = CGPointMake(tankLeft.position.x + velocity.x * delta, tankLeft.position.y + velocity.y * delta);
		tankDown.position = CGPointMake(tankLeft.position.x + velocity.x * delta, tankLeft.position.y + velocity.y * delta);
        if (velocity.y > 0) {
            tankUp.visible = YES;
            tankDown.visible = NO;
            tankLeft.visible = NO;
            tankRight.visible = NO;
        }
        if (velocity.y < 0) {
            tankUp.visible = NO;
            tankDown.visible = YES;
            tankLeft.visible = NO;
            tankRight.visible = NO;
        }
        if (velocity.x > 0&&velocity.x > ABS(velocity.y)) {
            tankUp.visible = NO;
            tankDown.visible = NO;
            tankLeft.visible = NO;
            tankRight.visible = YES;
        }
        if (velocity.x < 0&&-velocity.x > ABS(velocity.y)) {
            tankUp.visible = NO;
            tankDown.visible = NO;
            tankLeft.visible = YES;
            tankRight.visible = NO;
        }
	}
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end

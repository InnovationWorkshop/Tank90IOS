//
//  HelloWorldLayer.h
//  Tank90
//
//  Created by Nullin on 13-5-28.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    SneakyJoystick *btnJoystick;
    SneakyButton *btnFire;
    CCSprite *tankLeft;
    CCSprite *tankUp;
    CCSprite *tankRight;
    CCSprite *tankDown;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

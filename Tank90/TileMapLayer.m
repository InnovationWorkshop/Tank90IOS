//
//  TileMapLayer.m
//  Tank90
//
//  Created by Nullin on 13-8-22.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "TileMapLayer.h"
#import "HelloWorldLayer.h"

@implementation TileMapLayer
-(id)init{
    self = [super init];
    if (self) {
        CCTMXTiledMap* tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"stage1.tmx"];
        [self addChild:tileMap z:-1 tag:@"TileMapNode"];
        CCTMXLayer* eventLayer = [tileMap layerNamed:@"Tiles"];
        eventLayer.visible = YES;
    }
    return self;
}
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    
	// 'layer' is an autorelease object.
	TileMapLayer *layer = [TileMapLayer node];
	HelloWorldLayer *helloLayer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	[scene addChild: helloLayer];
	
	// return the scene
	return scene;
}
@end

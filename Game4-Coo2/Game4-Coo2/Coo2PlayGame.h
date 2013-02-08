//
//  Coo2PlayGame.h
//  Game4-Coo2
//
//  Created by Chalermchon Samana on 2/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Coo2Tile.h"

#define GAME_STATE_NEW_GAME 0
#define GAME_STATE_RUNNING  1
#define GAME_STATE_LOSE     2
#define GAME_STATE_WIN      3

@interface Coo2PlayGame : CCLayerColor <Coo2TileDelegate>{
    
}

+(CCScene*)scene;

@end

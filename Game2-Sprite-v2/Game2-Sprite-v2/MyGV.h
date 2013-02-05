//
//  MyGV.h
//  Game2-Sprite-v2
//
//  Created by Chalermchon Samana on 2/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define ACTION_IDLE         0
#define ACTION_RUNNING      1
#define ACTION_JUMP         2
#define ACTION_JUMP_DOWN    3
#define ACTION_DUCKING      4

@interface MyGV : CCSprite {
    
}

-(id)initWithPosition:(CGPoint)location;

@end

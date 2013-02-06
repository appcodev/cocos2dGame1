//
//  Sonic.h
//  Game3-Sound
//
//  Created by Chalermchon Samana on 2/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define ACTION_IDLE_1   0
#define ACTION_IDLE_2   1
#define ACTION_IDLE_3   2
#define ACTION_HIT_1    3
#define ACTION_HIT_2    4

@interface Sonic : CCSprite {
    
}

-(id)initWithPosition:(CGPoint)location;
-(void)setAction:(int)act;

@end

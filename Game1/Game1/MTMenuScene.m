//
//  MTMenuScene.m
//  Game1
//
//  Created by Chalermchon Samana on 2/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MTMenuScene.h"


@implementation MTMenuScene

+(id)scene{
    return [[[self alloc] init] autorelease];
}

-(id)init{
    if(self=[super init]){
        MTMenuLayer *mtMenu = [MTMenuLayer node];
        [self addChild:mtMenu];//scene add layer
    }
    
    return self;
}

@end

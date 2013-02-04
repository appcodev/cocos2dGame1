//
//  MTPlayFieldScene.m
//  Game1
//
//  Created by Chalermchon Samana on 2/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MTPlayFieldScene.h"
#import "MTPlayFieldLayer.h"

@implementation MTPlayFieldScene

+(id) sceneWithRows:(int)row andColumns:(int)col{
    return [[[self alloc] initSceneWithRows:row andColumns:col] autorelease];
}

-(id) initSceneWithRows:(int)row andColumns:(int)col{
    if(self = [super init]){
        //create instance of play field layer
        MTPlayFieldLayer *mtPlayFieldLayer = [MTPlayFieldLayer layerWithRows:row andColumns:col];
        [self addChild:mtPlayFieldLayer];
    }
    
    return self;
}

@end

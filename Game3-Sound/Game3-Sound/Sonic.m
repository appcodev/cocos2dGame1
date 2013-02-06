//
//  Sonic.m
//  Game3-Sound
//
//  Created by Chalermchon Samana on 2/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Sonic.h"

@interface Sonic(){
    NSMutableArray *animateList;
    int action;
}

@end

@implementation Sonic

-(id)initWithPosition:(CGPoint)location{
    
    if(self = [super initWithSpriteFrameName:@"idle01.png"]){
        [self setPosition:location];
        
        animateList = [[NSMutableArray alloc] init];
        
        //idle 1
        //1. create sprite frames (array)
        NSMutableArray *idleSpFrames = [[NSMutableArray alloc] init];
        for(int i=1;i<=6;i++){
            CCSpriteFrame *spFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"idle%02d.png",i]];
            [idleSpFrames addObject:spFrame];
        }
        //2. CCAnimation animationWithSpriteFrames:
        CCAnimation *idleAnimation = [CCAnimation animationWithSpriteFrames:idleSpFrames delay:0.2];
        //3. CCAnimate / create Action by CCRepeat
        CCAnimate *idleAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idleAnimation]];
        //4. add into list
        [animateList addObject:idleAnimate];
        
        //idle 2
        NSMutableArray *idle2SpFrames = [[NSMutableArray alloc] init];
        for(int i=1;i<=6;i++){
            CCSpriteFrame *spFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"idle2-%d.png",i]];
            [idle2SpFrames addObject:spFrame];
        }
        CCAnimation *idle2Animation = [CCAnimation animationWithSpriteFrames:idle2SpFrames delay:0.2];
        CCAnimate *idle2Anime = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idle2Animation]];
        [animateList addObject:idle2Anime];
        
        
        //idle 3
        NSMutableArray *idle3SpFrames = [[NSMutableArray alloc] init];
        for(int i=1;i<=6;i++){
            CCSpriteFrame *spFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"idle3-%d.png",i]];
            [idle3SpFrames addObject:spFrame];
        }
        CCAnimation *idle3Animation = [CCAnimation animationWithSpriteFrames:idle3SpFrames delay:0.2];
        CCAnimate *idle3Animate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idle3Animation]];
        [animateList addObject:idle3Animate];
        
        //hit 1
        NSMutableArray *hit1SpFrames = [[NSMutableArray alloc] init];
        for(int i=1;i<=5;i++){
            CCSpriteFrame *spFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"norhit%02d.png",i]];
            [hit1SpFrames addObject:spFrame];
        }
        CCAnimation *hit1Animation = [CCAnimation animationWithSpriteFrames:hit1SpFrames delay:0.2];
        CCAnimate *hit1Animate = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:hit1Animation] times:5];
        CCAnimate *hit1AnimateDone = [CCCallFuncN actionWithTarget:self selector:@selector(hitActionDone)];
        //use sequence
        CCSequence *hit1Seq = [CCSequence actions:hit1Animate,hit1AnimateDone, nil];
        [animateList addObject:hit1Seq];
        
        //hit 2
        NSMutableArray *hit2SpFrames = [[NSMutableArray alloc] init];
        for(int i=1;i<=4;i++){
            CCSpriteFrame *spFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"hit%02d.png",i]];
            [hit2SpFrames addObject:spFrame];
        }
        CCAnimation *hit2Animation = [CCAnimation animationWithSpriteFrames:hit2SpFrames delay:0.2];
        CCAnimate *hit2Animate = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:hit2Animation] times:5];
        CCAnimate *hit2AnimateDone = [CCCallFuncN actionWithTarget:self selector:@selector(hitActionDone)];
        //use sequence
        CCSequence *hit2Seq = [CCSequence actions:hit2Animate,hit2AnimateDone, nil];
        [animateList addObject:hit2Seq];
        
        action = -1;
        [self setAction:ACTION_IDLE_1];
    }
    
    return self;
    
}

-(void)setAction:(int)act{
    
    if(action!=act){
        if(action>=0){
            [self stopAction:animateList[action]];
        }
        action = act;
        [self runAction:animateList[action]];
    }
    
    
}

-(void)hitActionDone{
    [self setAction:ACTION_IDLE_1];
}

-(void)dealloc{
    
    [super dealloc];
}


@end

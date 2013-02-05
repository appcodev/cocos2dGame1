//
//  MyGV.m
//  Game2-Sprite-v2
//
//  Created by Chalermchon Samana on 2/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MyGV.h"
#import "AppDelegate.h"

@interface MyGV(){
    NSMutableArray *listAnimation;
    int action;
    BOOL run2Right;
}

@end

@implementation MyGV

-(id)initWithPosition:(CGPoint)location{
    
    if(self = [super initWithSpriteFrameName:@"idle01.png"]){
        [self setPosition:ccp(location.x,location.y)];
        
        listAnimation = [[NSMutableArray alloc] init];
        
        //idle action
        NSMutableArray *idleAction = [[NSMutableArray alloc] init];
        for(int i=1;i<=8;i++){
            NSString *fName = [NSString stringWithFormat:@"idle%02d.png",i];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fName];
            [idleAction addObject:frame];
        }
        CCAnimation *idleAm = [CCAnimation animationWithSpriteFrames:idleAction delay:0.1];
        CCAnimate *idleAnimation = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idleAm]];
        [listAnimation addObject:idleAnimation];
        
        //run action
        NSMutableArray *runAction = [[NSMutableArray alloc] init];
        for(int i=1;i<=12;i++){
            NSString *fName = [NSString stringWithFormat:@"running%02d.png",i];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fName];
            [runAction addObject:frame];
        }
        CCAnimation *runningAm = [CCAnimation animationWithSpriteFrames:runAction delay:0.1];
        CCAnimate *runningAnimation = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:runningAm]];
        [listAnimation addObject:runningAnimation];
        
        //jump action
        NSMutableArray *jumpAction = [[NSMutableArray alloc] init];
        for(int i=1;i<=11;i++){
            NSString *fName = [NSString stringWithFormat:@"jump%02d.png",i];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fName];
            [jumpAction addObject:frame];
        }
        CCAnimation *jumpAm = [CCAnimation animationWithSpriteFrames:jumpAction delay:0.5];
        CCAnimate *jumpAnimation = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:jumpAm] times:1];
        [listAnimation addObject:jumpAnimation];
        
        //ducking action
        NSMutableArray *duckingAction = [[NSMutableArray alloc] init];
        for(int i=1;i<=4;i++){
            NSString *fName = [NSString stringWithFormat:@"ducking%02d.png",i];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fName];
            [duckingAction addObject:frame];
        }
        CCAnimation *duckingAm = [CCAnimation animationWithSpriteFrames:duckingAction delay:0.5];
        CCAnimate *duckingAnimation = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:duckingAm] times:1];
        
        [listAnimation addObject:duckingAnimation];//jump down
        [listAnimation addObject:duckingAnimation];//ducking use same action frames
        
        action = ACTION_IDLE;
        [self runAction:listAnimation[action]];
        
        run2Right = YES;
        
        [self schedule:@selector(heroLoop:) interval:0.01f];
    }
    
    
    return self;
    
}

-(void)heroLoop:(ccTime) time{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int newAction = 0;
    //action
    if(self.position.y > 50+self.boundingBox.size.height/2 ){//sky
        if (action==ACTION_IDLE || action==ACTION_DUCKING) {
            newAction = ACTION_DUCKING;
            //NSLog(@"new action : DUCKING");
        }else if(action==ACTION_JUMP){
            if(self.position.y > 300){
                newAction = ACTION_JUMP_DOWN;
                //NSLog(@"new action : JUMP.....DOWN II");
            }else{
                newAction = ACTION_JUMP;
                //NSLog(@"new action : JUMP..... II");
            }
        }else if(action==ACTION_JUMP_DOWN){
            newAction = ACTION_JUMP_DOWN;
            //NSLog(@"new action : JUMP.. ..DOWN");
        }
    }else{//floor
        int jRnd = arc4random()%1000;
        if(jRnd>99 && jRnd<=110){
            newAction = ACTION_JUMP;
            //NSLog(@"new action : JUMP.....");
        }else{
            if(action!=ACTION_JUMP){
                newAction = ACTION_RUNNING;
                //NSLog(@"new action : RUNNING.....");
            }else{
                newAction = ACTION_JUMP;
                //NSLog(@"new action : JUMP.. XX ..");
            }
        }
    }
    
    
    if(newAction!=action){
        [self stopAction:listAnimation[action]];
        action = newAction;
        [self runAction:listAnimation[action]];
    }
    
    //update position
    float speed = 250*time;
    switch (action) {
        case ACTION_DUCKING:{
            [self setPosition:ccp(self.position.x, self.position.y-speed)];
            break;
        }
        case ACTION_JUMP:{
            if(run2Right){
                self.flipX = NO;
                [self setPosition:ccp(self.position.x+speed*0.2, self.position.y+speed)];
                if(self.position.x > winSize.width-self.boundingBox.size.width){
                    run2Right = NO;
                }
            }else{
                self.flipX = YES;
                [self setPosition:ccp(self.position.x-speed*0.2, self.position.y+speed)];
                if(self.position.x < 0+self.boundingBox.size.width){
                    run2Right = YES;
                }
            }

            break;
        }
        case ACTION_JUMP_DOWN:{
            if(run2Right){
                self.flipX = NO;
                [self setPosition:ccp(self.position.x+speed*0.2, self.position.y-speed)];
                if(self.position.x > winSize.width-self.boundingBox.size.width){
                    run2Right = NO;
                }
            }else{
                self.flipX = YES;
                [self setPosition:ccp(self.position.x-speed*0.2, self.position.y-speed)];
                if(self.position.x < 0+self.boundingBox.size.width){
                    run2Right = YES;
                }
            }
            
            break;
        }
        case ACTION_RUNNING:{
            if(self.position.y < 50){
                [self setPosition:ccp(self.position.x, 50)];
            }
            if(run2Right){
                self.flipX = NO;
                [self setPosition:ccp(self.position.x+speed, self.position.y)];
                if(self.position.x > winSize.width-self.boundingBox.size.width){
                    run2Right = NO;
                }
            }else{
                self.flipX = YES;
                [self setPosition:ccp(self.position.x-speed, self.position.y)];
                if(self.position.x < 0+self.boundingBox.size.width){
                    run2Right = YES;
                }
            }
            break;
        }
            
    }
    
}


-(void)dealloc{
    [listAnimation release];
    
    [super dealloc];
}

@end

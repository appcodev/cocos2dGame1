//
//  GameTouch.m
//  Game2-Sprite-v2
//
//  Created by Chalermchon Samana on 2/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameTouch.h"
#import "AppDelegate.h"

@interface GameTouch(){
    CCSpriteBatchNode *sheet;
    CCLabelTTF *monCount;
}

@end

@implementation GameTouch

+(CCScene*)scene{
    
    CCScene *scene = [CCScene node];
    GameTouch *game = [GameTouch node];
    [scene addChild:game];
    
    return scene;
    
}

-(id)init{
    if(self=[super initWithColor:ccc4(255, 255, 255, 255)]){
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gv01_default.plist"];
        sheet = [CCSpriteBatchNode batchNodeWithFile:@"gv01_default.png"];
        [self addChild:sheet];
        
        self.isTouchEnabled = YES;
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCTexture2D *gTexture = [[CCTextureCache sharedTextureCache] addImage:@"gTexture.png"];
        CCSprite *ground = [[CCSprite alloc] initWithTexture:gTexture rect:CGRectMake(0, 0, winSize.width, 50)];
        [ground setPosition:ccp(winSize.width/2,25)];
        [self addChild:ground];
        
        monCount = [[CCLabelTTF alloc] initWithString:@"0" fontName:@"Verdana" fontSize:50];
        [monCount setColor:ccc3(200, 200, 0)];
        [monCount setPosition:ccp(winSize.width/2, winSize.height-100)];
        [self addChild:monCount];
        
    }
    
    return self;
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in touches){
    
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        
        
        MyGV *gv = [[[MyGV alloc] initWithPosition:location] autorelease];
        [sheet addChild:gv];
        
        [monCount setString:[NSString stringWithFormat:@"%d",sheet.children.count]];
    }
}

-(void)dealloc{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    [super dealloc];
}

@end

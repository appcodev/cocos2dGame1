//
//  Coo2MainMenuGame.m
//  Game4-Coo2
//
//  Created by Chalermchon Samana on 2/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Coo2MainMenuGame.h"
#import "Coo2PlayGame.h"


@implementation Coo2MainMenuGame

+(CCScene*)scene{
    CCScene *scene = [CCScene node];
    Coo2MainMenuGame *game = [Coo2MainMenuGame node];
    [scene addChild:game];
    
    return scene;
}

-(id)init{
    if(self = [super initWithColor:ccc4(255, 255, 255, 255)]){
    
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        //bg
        CCSprite *bg = [CCSprite spriteWithFile:@"coo2-bg.jpg"];
        float scaleWin = winSize.width/bg.boundingBox.size.width;
        [bg setPosition:ccp(winSize.width/2, winSize.height/2)];
        [bg setScale:scaleWin];
        [self addChild:bg];
        
        //NSLog(@"scale : %f",scaleWin);
        
        //logo
        CCSprite *logo = [CCSprite spriteWithFile:@"coo2logo.png"];
        [logo setPosition:ccp(winSize.width/2, winSize.height/2+200)];
        [logo setScale:scaleWin];
        [self addChild:logo];
    
    
        CCMenu *menu = [CCMenu node];
        CCMenuItemImage *playButton = [CCMenuItemImage itemWithNormalImage:@"play-button-1.png" selectedImage:@"play-button-2.png" target:self selector:@selector(onMenuClicked:)];
        [playButton setScale:scaleWin];
        [menu addChild:playButton];
        [menu setPosition:ccp(winSize.width/2, winSize.height/2-200)];
    
        [self addChild:menu];
    
    }
    
    return self;
}

-(void)onMenuClicked:(CCMenuItemFont*)sender{
    [[CCDirector sharedDirector] replaceScene:[Coo2PlayGame scene]];
}


-(void)dealloc{
    
    [super dealloc];
}

@end

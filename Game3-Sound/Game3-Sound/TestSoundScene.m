//
//  TestSoundScene.m
//  Game3-Sound
//
//  Created by Chalermchon Samana on 2/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "TestSoundScene.h"
#import "Sonic.h"
#import "SimpleAudioEngine.h"

@interface TestSoundScene(){
    CCSpriteBatchNode *sheet;
    Sonic *sonic;
    
}

@end

@implementation TestSoundScene

+(CCScene*)scene{
    
    CCScene *scene = [CCScene node];
    TestSoundScene *layer = [TestSoundScene node];
    [scene addChild:layer];
    
    return scene;
}

-(id)init{
    
    if(self = [super init]){
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        //bg
        CCSprite *bg = [CCSprite spriteWithFile:@"bg1.jpg"];
        [bg setPosition:ccp(winSize.width/2, winSize.height/2)];
        int scale = winSize.width/bg.boundingBox.size.width;
        [bg setScale:scale];//test scale size
        
        [self addChild:bg];
        
        //sprite sheet
        //1. ccspriteframecache with file : plish
        //2. ccspritebatchnode with file : .png
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sn-sprite_default.plist"];
        sheet = [CCSpriteBatchNode batchNodeWithFile:@"sn-sprite_default.png"];
        [self addChild:sheet];
        
        //sonic
        sonic = [[[Sonic alloc] initWithPosition:ccp(winSize.width/2, winSize.height/2-43*scale)] autorelease];
        [sheet addChild:sonic];
        
        //button
        NSMutableArray *listMenuItems = [[NSMutableArray alloc] init];
        NSArray *listMenuName = @[@"button-1.png",@"button-2.png",@"button-3.png",@"button-4.png",@"button-5.png",@"button-bg-2.png",@"button-bg-1.png"];
        for (int i=0; i<listMenuName.count; i++) {
            CCMenuItem *menuItem = [CCMenuItemImage itemWithNormalImage:listMenuName[i]
                                                          selectedImage:listMenuName[i]
                                                                 target:self
                                                               selector:@selector(onChangeAction:)];
            [menuItem setTag:i];
            
            [listMenuItems addObject:menuItem];
        }
        
        
        
        CCMenu *menu = [CCMenu menuWithArray:[listMenuItems objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 5)]]];
        CCMenuItemToggle *bgSoundToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(onChangeAction:) items:listMenuItems[5],listMenuItems[6], nil];
        [bgSoundToggle setTag:5];//fix
        [menu addChild:bgSoundToggle];
        
        [menu setPosition:ccp(winSize.width/2, 100*scale)];
        [menu alignItemsHorizontallyWithPadding:20*scale];
        [self addChild:menu];
        
        
        //sound
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgSound1.mp3"];
        
    }
    
    return self;
    
}

-(void)onChangeAction:(CCMenuItem*)sender{
    if(sender.tag<5){
        [sonic setAction:sender.tag];
        [[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"fx%d.caf",sender.tag]];
    }else{
        CCMenuItemToggle *tg = (CCMenuItemToggle*)sender;
        if(tg.selectedIndex==0){//on
            [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        }else{//close
            [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        }
    }
}


-(void)dealloc{
    [sheet release];
    //[sonic release];
    
    [super dealloc];
}




@end

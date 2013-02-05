//
//  GameMenu.m
//  Game1-Menu
//
//  Created by Chalermchon Samana on 2/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameMenu.h"
#import "AppDelegate.h"

@interface GameMenu (){
    int fontSize;
    CCLabelTTF *title;
}

@end

@implementation GameMenu

+(CCScene*) scene{
    CCScene *scene = [CCScene node];
    
    GameMenu *gameMenuLayer = [GameMenu node];
    
    [scene addChild:gameMenuLayer];
    
    return scene;
}

-(id) init{
    if(self = [super initWithColor:ccc4(200, 40, 40, 255)]){
        
        //create menu
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //ใส่ Text เข้าไป
        fontSize = 50;
        title = [[CCLabelTTF alloc] initWithString:@"Appa Game โย่" fontName:@"Marker Felt" fontSize:fontSize];
        [title setPosition:ccp(size.width/2, size.height/2)];
        [title setColor:ccc3(0, 255, 255)];
        [self addChild:title];
        
        
        //add menu
        [CCMenuItemFont setFontSize:100];
        CCMenuItem *menu1 = [CCMenuItemFont itemWithString:@"+" target:self selector:@selector(increaseFont)];
        
        CCMenuItem *menu2 = [CCMenuItemFont itemWithString:@"-" target:self selector:@selector(decreseFont)];
        
        
        CCMenu *menu = [CCMenu menuWithItems:menu1,menu2, nil];
        [menu alignItemsHorizontallyWithPadding:20];
        [menu setPosition:ccp(size.width/2, size.height-90)];
        [self addChild:menu];
        
        
    }
    
    return self;
}

-(void)increaseFont{
    fontSize = ++fontSize>72?72:fontSize;
    [title setFontSize:fontSize];
}

-(void)decreseFont{
    fontSize = --fontSize<20?20:fontSize;
    [title setFontSize:fontSize];
    
}


@end

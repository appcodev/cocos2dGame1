//
//  MyGameTouch.m
//  Game2-Sprite
//
//  Created by Chalermchon Samana on 2/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MyGameTouch.h"
#import "AppDelegate.h"

@interface MyGameTouch(){
    NSMutableArray *listHeroes;
}

@end


@implementation MyGameTouch

+(CCScene*) scene{
    CCScene *scene = [CCScene node];
    MyGameTouch *game = [MyGameTouch node];
    [scene addChild:game];
    
    return scene;
}

-(id)init{
    if(self=[super initWithColor:ccc4(50, 200, 50, 255)]){
        
        listHeroes = [[NSMutableArray alloc] init];
        
        self.isTouchEnabled = YES;
        
        
        [self schedule:@selector(gameLoop)];
    }
    
    return self;
}

-(void)gameLoop{
    if(listHeroes.count > 0){
        for (CCSprite *sp in listHeroes) {
            int y = sp.position.y;
            if(y==10) continue;
            
            sp.rotation = (int)y % 360;
            
            y -= sp.tag/2+2;
            if(y < 10){
                y=10;
            }
            
            [sp setPosition:ccp(sp.position.x, y)];
            
            
        }
        
        //NSLog(@"...");
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
    
        CGPoint location = [touch locationInView:[touch view]];
        //CGSize size = [[CCDirector sharedDirector] winSize];
        
        int pic = arc4random()%10+1;
        CCSprite *sp = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%d.png",pic]];
        [sp setTag:pic];
        location = [[CCDirector sharedDirector] convertToGL:location];
        [sp setPosition:ccp(location.x, location.y)];
        
        [listHeroes addObject:sp];
        [self addChild:sp];
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"size .. %d",touches.count);
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView:[touch view]];
        //CGSize size = [[CCDirector sharedDirector] winSize];
        
        int pic = arc4random()%10+1;
        CCSprite *sp = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%d.png",pic]];
        [sp setTag:pic];
        location = [[CCDirector sharedDirector] convertToGL:location];
        [sp setPosition:ccp(location.x, location.y)];

        [listHeroes addObject:sp];
        [self addChild:sp];
        
    }
    //NSLog(@"-list heroes- %d",listHeroes.count);
    
}

-(void)dealloc{
    [listHeroes release];
    [super dealloc];
}

@end

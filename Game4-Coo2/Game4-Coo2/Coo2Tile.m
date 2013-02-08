//
//  Coo2Tile.m
//  Game4-Coo2
//
//  Created by Chalermchon Samana on 2/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Coo2Tile.h"

@interface Coo2Tile(){
    CCSpriteFrame *bcakCardFrame,*animalFrame;
}

@end

@implementation Coo2Tile

-(id)initWithMonSpriteName:(NSString*)anName location:(CGPoint)location scale:(int)winScale{
    if(self = [super initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pic0.png"]]){
        _animalSpriteName = anName;
        
        animalFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:anName];
        bcakCardFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pic0.png"];
        
        [self setPosition:location];
        [self setScale:winScale];
        
        //flip
        _isShowPicFrame = NO;
        
        _isAlive = YES;
        
    }
    
    return self;
}


-(void)flipTileWithRespone:(BOOL)response{
    float duration = 0.25f;
    
    CCOrbitCamera *rotateToEdge = [CCOrbitCamera
                                   actionWithDuration:duration/2 radius:1
                                   deltaRadius:0 angleZ:0 deltaAngleZ:90
                                   angleX:0 deltaAngleX:0];
    CCOrbitCamera *rotateFlat = [CCOrbitCamera
                                 actionWithDuration:duration/2 radius:1
                                 deltaRadius:0 angleZ:270 deltaAngleZ:90
                                 angleX:0 deltaAngleX:0];
    
    if(response){
        [self runAction:[CCSequence actions: rotateToEdge,
                     [CCCallFuncN actionWithTarget:self selector:@selector(changeTile)],
                     rotateFlat,
                     [CCCallFuncN actionWithTarget:self selector:@selector(flipTileDone)],
                     nil]];
    }else{
        [self runAction:[CCSequence actions: rotateToEdge,
                         [CCCallFuncN actionWithTarget:self selector:@selector(changeTile)],
                         rotateFlat,nil]];
    }
}

-(void)changeTile{
    if(_isShowPicFrame){// => front frame
        [self setDisplayFrame:bcakCardFrame];
        
    }else{// => back frame
        [self setDisplayFrame:animalFrame];
        
    }
    
    _isShowPicFrame = !_isShowPicFrame;
}

-(void)flipTileDone{
    [self schedule:@selector(endFlipDelay) interval:0.25 repeat:0 delay:0.25];
}

-(void)endFlipDelay{
    [_delegate finishTapActionOn:self open:_isShowPicFrame picName:_animalSpriteName];
}

-(void)closeTile{
    if(_isShowPicFrame){
        [self flipTileWithRespone:NO];
    }
}

-(BOOL)isTouchTile:(CGPoint)p{
    BOOL isTouch = CGRectContainsPoint(self.boundingBox, p);
    if (isTouch) {
        [self flipTileWithRespone:YES];
    }
    return isTouch;
}

+(BOOL)compareTile1:(Coo2Tile*)tile1 withTile2:(Coo2Tile*)tile2{
    return [tile1.animalSpriteName isEqualToString:tile2.animalSpriteName];
}

-(void)complateTile{
    _isAlive = NO;
}


@end

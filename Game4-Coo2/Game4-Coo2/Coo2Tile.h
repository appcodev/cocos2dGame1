//
//  Coo2Tile.h
//  Game4-Coo2
//
//  Created by Chalermchon Samana on 2/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Coo2Tile;

@protocol Coo2TileDelegate <NSObject>

-(void)finishTapActionOn:(Coo2Tile*)tile open:(BOOL)open picName:(NSString*)picName;

@end

@interface Coo2Tile : CCSprite {
    
}
@property (nonatomic,strong)    NSString *animalSpriteName;
@property (nonatomic,readwrite) BOOL isShowPicFrame,isAlive;
@property (nonatomic,strong)    id<Coo2TileDelegate> delegate;

+(BOOL)compareTile1:(Coo2Tile*)tile1 withTile2:(Coo2Tile*)tile2;

-(id)initWithMonSpriteName:(NSString*)anName location:(CGPoint)location scale:(int)winScale;

-(BOOL)isTouchTile:(CGPoint)p;
-(void)closeTile;
-(void)complateTile;

@end

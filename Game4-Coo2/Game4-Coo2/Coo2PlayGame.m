//
//  Coo2PlayGame.m
//  Game4-Coo2
//
//  Created by Chalermchon Samana on 2/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Coo2PlayGame.h"
#import "Coo2MainMenuGame.h"
#import "SimpleAudioEngine.h"

#define SOUND_BUTTON    @"button.caf"
#define SOUND_BUZZER    @"buzzer.caf"
#define SOUND_HARPRUN   @"harprun.caf"
#define SOUND_WHOOSH    @"whoosh.caf"
#define SOUND_BG        @"sound_bg.mp3"

@interface Coo2PlayGame(){
    int game,time,score;
    CCLabelTTF *text1,*text2,*text3,*displayText;
    NSMutableArray *listTiles;
    
    CGSize winSize;
    float winScale;
    
    int gameState;
    BOOL threadRunning;
    
    NSMutableArray *useTiles;
    
    Coo2Tile *previousTile;
    int countOpenTile;
}

@end

@implementation Coo2PlayGame

+(CCScene*)scene{
    CCScene *scene = [CCScene node];
    Coo2PlayGame *game = [Coo2PlayGame node];
    
    [scene addChild:game];
    return scene;
}

-(id)init{
    if([self initWithColor:ccc4(255, 255, 255, 255)]){
        
        winSize = [[CCDirector sharedDirector] winSize];
        self.isTouchEnabled = YES;
        
        //load sound
        [self loadSound];
        
        //create UI : Text Button
        [self createUI];
        
    
        [self newGame];
        
        //game main loop
        [self schedule:@selector(gameLoop:) interval:1];
        
    }
    
    
    return self;
}

-(void)loadSound{
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:SOUND_BG];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BUTTON];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BUZZER];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_HARPRUN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_WHOOSH];
    
    //play
    //[[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.5];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:SOUND_BG];
}
                          
-(void)createUI{
        //bg
        CCSprite *bg = [CCSprite spriteWithFile:@"coo2-bg-2.jpg"];
        [bg setPosition:ccp(winSize.width/2, winSize.height/2)];
        winScale = winSize.width/bg.boundingBox.size.width;
        [bg setScale:winScale];
        [self addChild:bg];

        //text 1 game
        text1 = [CCLabelTTF labelWithString:@"1" fontName:@"Marker Felt" fontSize:50];
        [text1 setPosition:ccp(258,708)];
        [self addChild:text1];

        //text 2 time
        text2 = [CCLabelTTF labelWithString:@"60" fontName:@"Marker Felt" fontSize:90];
        [text2 setPosition:ccp(180,470)];
        [self addChild:text2];

        //text 3 score
        text3 = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:90];
        [text3 setPosition:ccp(180, 200)];
        [self addChild:text3];
    
        //display Text
        displayText = [CCLabelTTF labelWithString:@"NEW GAME" fontName:@"Marker Felt" fontSize:140];
        [displayText setPosition:ccp(winSize.width/2,winSize.height/2)];
        [displayText setColor:ccc3(200, 50, 200)];
        [displayText setZOrder:1001];
        [displayText setVisible:NO];
        [self addChild:displayText];

        //menu
        CCMenu *menu = [CCMenu node];
        NSArray *menuName = @[@"home-button.png"];//@[@"replay-button.png",@"home-button.png"];
        for(int i=0;i<menuName.count;i++){
            CCMenuItemImage *menuItem = [CCMenuItemImage itemWithNormalImage:menuName[i]
                                                               selectedImage:menuName[i]
                                                                      target:self
                                                                    selector:@selector(onMenuClicked:)];
            [menuItem setTag:i];
            [menuItem setScale:winScale];
            [menu addChild:menuItem];
        }

        [menu alignItemsHorizontallyWithPadding:50];
        [menu setPosition:ccp(winSize.width/2+350, winSize.height/2+320)];
        [self addChild:menu];
}

-(void)showDisplayText:(int)gs{
    NSArray *texts = @[@"NEW GAME",@"^^ START GAME ^^",@"++++ YOU LOSE ++++",@"### YOU WIN ###"];
    [displayText setScale:0.2];
    [displayText setString:texts[gs]];
    [displayText setVisible:YES];
    
    CCScaleBy *scaleBy = [CCScaleBy actionWithDuration:1 scale:4];
    CCDelayTime *delayTime = [CCDelayTime actionWithDuration:0.5];
    CCCallFuncN *hide = [CCCallFuncN actionWithTarget:self selector:@selector(hideTextDisplay)];
    CCSequence *seq = [CCSequence actions:scaleBy,delayTime,hide, nil];
    
    [displayText runAction:seq];
}

-(void)hideTextDisplay{
    [displayText setVisible:NO];
}



-(void)generateTiles{
    //pic1-15
    //random 8 pairs of tile
    NSMutableArray *allTilePics = [[NSMutableArray alloc] initWithArray:@[@"pic1.png",@"pic2.png",@"pic3.png",@"pic4.png",@"pic5.png",@"pic6.png",@"pic7.png",@"pic8.png",@"pic9.png",@"pic10.png",@"pic11.png",@"pic12.png",@"pic13.png",@"pic14.png",@"pic15.png"]];
    useTiles = [[NSMutableArray alloc] initWithCapacity:16];
    for(int i=0;i<8;i++){
        int index = arc4random()%allTilePics.count;
        [useTiles addObject:allTilePics[index]];
        [useTiles addObject:allTilePics[index]];
        [allTilePics removeObjectAtIndex:index];
    }
    
    //generate tile position 0-16
    for(int i=0;i<useTiles.count;i++){
        NSString *tempName = useTiles[i];
        int randIndex = arc4random()%useTiles.count;
        NSString *newName = useTiles[randIndex];
        [useTiles replaceObjectAtIndex:i withObject:newName];
        [useTiles replaceObjectAtIndex:randIndex withObject:tempName];
    }
    
    
    
}

-(void)createTiles{
        //sprite frame cache
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"coo2_default.plist"];
        
        listTiles = [[NSMutableArray alloc] init];
        
        /////////////////////////////////// board ///////////////////////////////////////
        for(int i=0;i<useTiles.count;i++){
            NSString *anName = useTiles[i];
            Coo2Tile *box = [[Coo2Tile alloc] initWithMonSpriteName:anName location:ccp(490+((i%4)*(130)), 145+((i/4)*(130))) scale:winScale];
            [box setDelegate:self];
            [self addChild:box];
            [listTiles addObject:box];
        }

}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(gameState==GAME_STATE_NEW_GAME || gameState==GAME_STATE_RUNNING){
    
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:touch.view];
        location = [[CCDirector sharedDirector] convertToGL:location];
        
        //first tap
        if(gameState==GAME_STATE_NEW_GAME){
            gameState = GAME_STATE_RUNNING;
            threadRunning = YES;//<<----
            [self showDisplayText:gameState];
        }
        
        for(Coo2Tile *box in listTiles){
            if(box.isAlive && !box.isShowPicFrame && countOpenTile<2){
                if([box isTouchTile:location]){
                    countOpenTile++;
                    //tap tile
                    [[SimpleAudioEngine sharedEngine] playEffect:SOUND_WHOOSH];
                }
            }
        }
    
    }
    
}

-(void)newGame{
    //stage
    game = 1;
    time = 30;
    score = 0;
    countOpenTile = 0;
    
    gameState = GAME_STATE_NEW_GAME;
    threadRunning = NO;
    previousTile = nil;
    
    [self updateUI];
    
    [self showDisplayText:gameState];
    
    //generate tile
    [self generateTiles];
    
    //create tile
    [self createTiles];
    
}

-(void)nextGameLevel{
    
    //next stage
    game    += 1;
    time    += 20;
    score   += game*100;
    countOpenTile = 0;
    
    gameState = GAME_STATE_NEW_GAME;
    threadRunning = NO;
    previousTile = nil;
    
    [self updateUI];
    
    [self showDisplayText:gameState];
    
    //generate tile
    [self generateTiles];
    
    //create tile
    [self createTiles];
    
}

-(void)gameLoop:(ccTime)times{
    if(threadRunning){
        switch (gameState) {
            case GAME_STATE_RUNNING:{
                time--;
                
                //update ui
                [self updateUI];
                
                if(time<=0){
                    gameState = GAME_STATE_LOSE;
                }
                break;
            }
            case GAME_STATE_LOSE:{
                NSLog(@"Lose");
                [self showDisplayText:gameState];
                threadRunning = NO;
                break;
            }
            case GAME_STATE_WIN:{
                NSLog(@"WIN");
                [self showDisplayText:gameState];
                threadRunning = NO;
                break;
            }
        }
    }
    
}

//update UI
-(void)updateUI{
    
    //check time
    time = time<0?0:time;
    
    [text1 setString:[NSString stringWithFormat:@"#%d",game]];
    [text2 setString:[NSString stringWithFormat:@"%d",time]];
    [text3 setString:[NSString stringWithFormat:@"%d",score]];
}

-(void)onMenuClicked:(CCMenuItemImage*)sender{
    switch (sender.tag) {
        
        case 0:{
            [[SimpleAudioEngine sharedEngine] playEffect:SOUND_BUTTON];
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            CCDirector *dir = [CCDirector sharedDirector];
            
            CCScene *home = [CCScene node];
            [home addChild:[Coo2MainMenuGame node]];
            
            if([dir runningScene]){
                [dir replaceScene:home];
            }else{
                [dir runWithScene:home];
            }
            break;
        }
    }
}

/////////////////////////////// Coo2Tile Delegate ////////////////////////
-(void)finishTapActionOn:(Coo2Tile *)tile open:(BOOL)open picName:(NSString *)picName{
    
    if(previousTile==nil){
        previousTile = tile;
        //NSLog(@"-- %@",previousTile);
    }else{
        //NSLog(@"--++-- %@",previousTile);
        if([Coo2Tile compareTile1:previousTile withTile2:tile]){
            [[SimpleAudioEngine sharedEngine] playEffect:SOUND_HARPRUN];
            [previousTile complateTile];
            [tile complateTile];
            
            //[self removeChild:previousTile cleanup:YES];
            //[self removeChild:tile cleanup:YES];
            [previousTile runAction:[self removeTileSequence:previousTile]];
            [tile runAction:[self removeTileSequence:tile]];
            
            //update score
            score+=time;
            //update time
            time+=1;
            [self updateUI];
            
            //check win
            if([self isWin]){
                gameState = GAME_STATE_WIN;
                //next game
                [self scheduleOnce:@selector(nextGameLevel) delay:2];
            }
            
        }else{
            [[SimpleAudioEngine sharedEngine] playEffect:SOUND_BUZZER];
            [previousTile closeTile];
            [tile closeTile];
        }
        
        previousTile = nil;
        countOpenTile = 0;
        
    }
}

-(BOOL)isWin{
    BOOL isWin=YES;
    for (Coo2Tile *tile in listTiles) {
        if(tile.isAlive){
            isWin = NO;
        }
    }
    
    return isWin;
}

-(CCSequence*)removeTileSequence:(Coo2Tile*)tile{
    CCMoveTo *move = [CCMoveTo actionWithDuration:0.5 position:text3.position];
    CCScaleTo *scale = [CCScaleTo actionWithDuration:0.3 scale:0.001];
    CCDelayTime *delay = [CCDelayTime actionWithDuration:0.1];
    CCCallFuncND *removeTile = [CCCallFuncND actionWithTarget:self selector:@selector(removeTile:) data:tile];
    return [CCSequence actions:move,scale,delay,removeTile, nil];
}

-(void)removeTile:(Coo2Tile*)tile{
    [tile removeFromParentAndCleanup:YES];
}



@end

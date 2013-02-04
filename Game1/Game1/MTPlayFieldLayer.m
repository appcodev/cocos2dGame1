//
//  MTPlayFieldLayer.m
//  Game1
//
//  Created by Chalermchon Samana on 2/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MTPlayFieldLayer.h"


@implementation MTPlayFieldLayer

+(id) layerWithRows:(int)row andColumns:(int)col{
    return [self node];
}

@end

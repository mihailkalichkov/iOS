//
//  MKFactory.m
//  Pirate Adventure
//
//  Created by Mihail Kalichkov on 11/14/14.
//  Copyright (c) 2014 Mihail Kalichkov. All rights reserved.
//

#import "MKFactory.h"
#import "MKTile.h"

@implementation MKFactory

-(NSArray *)tiles{
    MKTile *tile1 = [[MKTile alloc] init];
    tile1.story = @"story1";
    
    MKTile *tile2= [[MKTile alloc] init];
    tile2.story = @"story2";
    
    MKTile *tile3 = [[MKTile alloc] init];
    tile3.story = @"story3";
    
    NSMutableArray *firstColumn = [[NSMutableArray alloc] init];
    [firstColumn addObject:tile1];
    [firstColumn addObject:tile2];
    [firstColumn addObject:tile3];
    
    MKTile *tile4 = [[MKTile alloc] init];
    tile4.story = @"story4";
    
    MKTile *tile5 = [[MKTile alloc] init];
    tile5.story = @"story5";
    
    MKTile *tile6 = [[MKTile alloc] init];
    tile6.story = @"story6";
    
    NSMutableArray *secondColumn = [[NSMutableArray alloc] init];
    [secondColumn addObject:tile4];
    [secondColumn addObject:tile5];
    [secondColumn addObject:tile6];
    
    MKTile *tile7 = [[MKTile alloc] init];
    tile7.story = @"story7";
    
    MKTile *tile8 = [[MKTile alloc] init];
    tile8.story = @"story8";
    
    MKTile *tile9 = [[MKTile alloc] init];
    tile9.story = @"story9";
    
    NSMutableArray *thirdColumn = [[NSMutableArray alloc] init];
    [thirdColumn addObject:tile7];
    [thirdColumn addObject:tile8];
    [thirdColumn addObject:tile9];
    
    MKTile *tile10 = [[MKTile alloc] init];
    tile10.story = @"story10";
    
    MKTile *tile11 = [[MKTile alloc] init];
    tile11.story = @"story11";
    
    MKTile *tile12 = [[MKTile alloc] init];
    tile12.story = @"story12";
    
    NSMutableArray *fourthColumn = [[NSMutableArray alloc] init];
    [fourthColumn addObject:tile10];
    [fourthColumn addObject:tile11];
    [fourthColumn addObject:tile12];
    
    NSArray *tiles = [[NSArray alloc] initWithObjects:firstColumn, secondColumn, thirdColumn, fourthColumn, nil];
    
    return  tiles;
}

@end

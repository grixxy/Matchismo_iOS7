//
//  PlayingCard.h
//  Matchismo_iOS7
//
//  Created by Gregory on 11/8/13.
//  Copyright (c) 2013 Gregory. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end

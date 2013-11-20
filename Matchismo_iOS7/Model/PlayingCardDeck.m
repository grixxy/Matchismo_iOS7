//
//  PlayingCardDeck.m
//  Matchismo_iOS7
//
//  Created by Gregory on 11/8/13.
//  Copyright (c) 2013 Gregory. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck


-(instancetype)init{
  self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            
            }
        }
    
    
    }
    
    return self;
}


@end

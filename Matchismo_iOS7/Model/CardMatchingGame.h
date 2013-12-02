//
//  CardMatchingGame.h
//  Matchismo_iOS7
//
//  Created by Gregory on 12/1/13.
//  Copyright (c) 2013 Gregory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck;
- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card*) cardAtIndex:(NSUInteger)index;

@property(nonatomic, readonly) NSInteger score;

@end

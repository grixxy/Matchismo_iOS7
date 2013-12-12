//
//  CardMatchingGame.m
//  Matchismo_iOS7
//
//  Created by Gregory on 12/1/13.
//  Copyright (c) 2013 Gregory. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame()
@property(nonatomic, readwrite) NSInteger score;
@property(nonatomic, readwrite) LastMatchingResult* lastMatchingResult;
@property(nonatomic, strong) NSMutableArray* cards;//of Cards
@property(nonatomic) NSUInteger cardsToMatch;

@end

@implementation CardMatchingGame

-(NSMutableArray*)cards{
    if(!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

-(LastMatchingResult*) lastMatchingResult{
    if(!_lastMatchingResult){
        _lastMatchingResult = [[LastMatchingResult alloc] init];
    }
    return _lastMatchingResult;
}


- (instancetype) initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck comaring:(NSUInteger)numberOfCards{
    self = [super init];
    self.cardsToMatch = numberOfCards;
    if(self){
        
        for(int i=0;i<count;i++){
            Card* card = [deck drawRandomCard];
            if(card){
             [self.cards addObject:card];
            } else {
                self = nil;
                break;
            };
        }
    }
    return self;
}

- (Card*) cardAtIndex:(NSUInteger)index{
    return (index<self.cards.count)?self.cards[index]:nil;
}



static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (void) chooseCardAtIndex:(NSUInteger)index{
    
    Card* card = [self cardAtIndex:index];
    
    if([self cardCanBeFlipped:card]){
        if(card.isChosen){
            card.chosen = NO;
        } else {
            [self flipAndShowCard:card];
        }
    
    }

}

-(bool) cardCanBeFlipped:(Card*) card{
    return !card.isMatched;
}

-(void) flipAndShowCard:(Card*)card{
    card.chosen = YES;
    self.score -= COST_TO_CHOOSE;
    if([self timeToCountScore]){
        [self countScore:card];
    }
    
}

-(bool)timeToCountScore{
    return [self unmatchedFlippedCards].count==self.cardsToMatch;
}

-(NSArray*)unmatchedFlippedCards{
    NSMutableArray* unmatchedFlippedCards = [[NSMutableArray alloc]init];
    for(Card* card in self.cards){
        if(card.isChosen&&!card.isMatched){
            [unmatchedFlippedCards addObject:card];
        }
    }
    return unmatchedFlippedCards;
}


-(void) countScore:(Card*) lastCard {
    NSArray *unmatchedFlippedCards = [self unmatchedFlippedCards];
    int matchScore = [self match:unmatchedFlippedCards];
    
    self.lastMatchingResult.operands = unmatchedFlippedCards;
    
    
     if(matchScore){
         self.lastMatchingResult.score = matchScore * MATCH_BONUS;
         for(PlayingCard* card in unmatchedFlippedCards){
             card.matched = YES;
         }
      } else {
          self.lastMatchingResult.score = -MISMATCH_PENALTY;
          for(PlayingCard* card in unmatchedFlippedCards){
              card.chosen = NO;
          }
          lastCard.chosen = YES;
      }
    
      self.score +=self.lastMatchingResult.score;
    
}

const int RANK_MATCH_BONUS = 4;


-(int) match:(NSArray *)cardsToMatch{
    int score = 0;
    NSMutableSet* ranks = [[NSMutableSet alloc] init];
    NSMutableSet* suits = [[NSMutableSet alloc] init];
    for(PlayingCard* card in cardsToMatch){
        [ranks addObject:[NSNumber numberWithInteger:card.rank]];
        [suits addObject:card.suit];
    };
    
    score = (cardsToMatch.count - ranks.count)*RANK_MATCH_BONUS;
    score +=(cardsToMatch.count - suits.count);
    
    return score;
    
}


@end

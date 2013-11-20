//
//  Card.m
//  Matchismo_iOS7
//
//  Created by Gregory on 11/8/13.
//  Copyright (c) 2013 Gregory. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray*)otherCards{

    int score = 0;
    for(Card *card in otherCards){
        if([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
     
    }
    
    return score;
}

@end

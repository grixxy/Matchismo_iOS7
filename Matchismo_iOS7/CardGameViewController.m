//
//  CardGameViewController.m
//  Matchismo_iOS7
//
//  Created by Gregory on 11/5/13.
//  Copyright (c) 2013 Gregory. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardsToMatch;
@property (weak, nonatomic) IBOutlet UILabel *lastResultLabel;

@end

@implementation CardGameViewController

-(CardMatchingGame*) game{
    NSUInteger numberOfCardsToMatch = self.cardsToMatch.selectedSegmentIndex==0?2:3;
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[self createDeck] comaring:numberOfCardsToMatch];
    [self.cardsToMatch setEnabled:FALSE];
    return _game;

}
- (IBAction)reDeal:(id)sender {
    self.game = nil;
    [self updateUI];
    [self.cardsToMatch setEnabled:TRUE];
    
}


-(Deck*) createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
 
}

-(void)updateUI{
    
    for(UIButton* cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastResultLabel.text = [self lastResultString];

}

-(NSString*) lastResultString{
    NSString* lastResultString = @"";
    if(self.game.lastMatchingResult.operands){
        
        NSString* cards = [self.game.lastMatchingResult.operands componentsJoinedByString:@" "];
        if(self.game.lastMatchingResult.score>0){
            
            NSString* points = [NSString stringWithFormat:@" for %d points", self.game.lastMatchingResult.score];
            lastResultString = [[@"Matched " stringByAppendingString:cards] stringByAppendingString:points];
        } else {
            
            NSString* points = [NSString stringWithFormat:@"%d points penalty!", self.game.lastMatchingResult.score];
            lastResultString = [[cards stringByAppendingString:@" don't match! "] stringByAppendingString:points];
        }
    }
    return lastResultString;

}

-(NSAttributedString*)titleForCard:(Card*)card{
    NSMutableAttributedString* attrTitle;
    if(card.isChosen){
        attrTitle = [[NSMutableAttributedString alloc]initWithString: card.contents];
        [attrTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,card.contents.length)];
        
    } else {
        attrTitle = [[NSMutableAttributedString alloc]initWithString: @""];
    }
    
    return attrTitle;
}

-(UIImage*)backgroundImageForCard:(Card*)card{
    return [UIImage imageNamed:card.isChosen? @"cardfront":@"cardBack"];
}
         
@end

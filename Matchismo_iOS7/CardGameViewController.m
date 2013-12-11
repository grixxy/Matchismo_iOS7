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
- (IBAction)changeNumberOfCardSelector:(id)sender {
    self.game = nil;
    [self updateUI];
    
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
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

}

-(NSString*)titleForCard:(Card*)card{
    
    return card.isChosen?card.contents:@"";
}

-(UIImage*)backgroundImageForCard:(Card*)card{
    return [UIImage imageNamed:card.isChosen? @"cardfront":@"cardBack"];
}
         
@end

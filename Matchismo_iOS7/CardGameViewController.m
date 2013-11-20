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

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck* deck;

@end

@implementation CardGameViewController

-(Deck*) deck{
    if(!_deck){
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}
-(void) setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];

}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if([sender.currentTitle length]){
        
        [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        
    } else {
    
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
        [sender setTitle:[[self.deck drawRandomCard]contents] forState:UIControlStateNormal];
        
    
    }
    
    self.flipCount++;
}

@end

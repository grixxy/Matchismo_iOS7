//
//  Card.h
//  Matchismo_iOS7
//
//  Created by Gregory on 11/8/13.
//  Copyright (c) 2013 Gregory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

-(int) match:(NSArray *)otherCards;

@end

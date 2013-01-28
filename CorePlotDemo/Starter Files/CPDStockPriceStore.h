//
//  CPDStockPriceStore.h
//  CorePlotDemo
//
//  Created by Steve Baranski on 5/4/12.
//  Copyright (c) 2012 komorka technology, llc. All rights reserved.
//

@interface CPDStockPriceStore : NSObject

+ (CPDStockPriceStore *)sharedInstance;

- (NSArray *)tickerSymbols;

- (NSArray *)dailyPortfolioPrices;

- (NSArray *)datesInWeek;
- (NSArray *)weeklyPrices:(NSString *)tickerSymbol;

- (NSArray *)datesInMonth;
- (NSArray *)monthlyPrices:(NSString *)tickerSymbol;

@end

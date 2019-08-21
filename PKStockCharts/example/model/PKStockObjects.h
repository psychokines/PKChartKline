//
//  PKStockObjects.h
//  PKStockCharts
//
//  Created by zhanghao on 2019/7/12.
//  Copyright © 2019年 PsychokinesisTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKTimeChartProtocol.h"
#import "PKKLineChartProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface PKStockItem : NSObject

@property (nonatomic, assign) BOOL isSuspended;
@property (nonatomic, assign) NSInteger marketId;

@property (nonatomic, assign) NSInteger stockType;
@property (nonatomic, strong) NSString *stockCode;
@property (nonatomic, strong) NSString *stockSign;
@property (nonatomic, strong) NSString *stockName;

@property (nonatomic, assign) CGFloat price_highest;
@property (nonatomic, assign) CGFloat price_lowest;
@property (nonatomic, assign) CGFloat price_open;
@property (nonatomic, assign) CGFloat price_change;
@property (nonatomic, assign) CGFloat price_changeRatio;
@property (nonatomic, assign) CGFloat price_yesterdayClose;

@property (nonatomic, assign) NSInteger date;
@property (nonatomic, assign) NSInteger dateTime;

@end

@interface PKTimeItem : NSObject <PKTimeChartProtocol, PKTimeChartCoordProtocol>

@property (nonatomic, assign) NSInteger volume;
@property (nonatomic, assign) CGFloat price_change;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) CGFloat price_change_rate;
@property (nonatomic, assign) CGFloat turnover;
@property (nonatomic, assign) NSInteger total_volume;
@property (nonatomic, assign) CGFloat avg_price;
@property (nonatomic, strong) NSString *date;

@end

@interface PKKlineItem : NSObject <PKKLineChartProtocol>

@property (nonatomic , assign) CGFloat close_price; // 收盘价
@property (nonatomic , assign) CGFloat high_price;  // 最高价
@property (nonatomic , assign) CGFloat low_price;   // 最低价
@property (nonatomic , assign) CGFloat open_price;  // 开盘价
@property (nonatomic , assign) CGFloat price_change; // 涨跌
@property (nonatomic , assign) CGFloat price_change_rate; // 涨跌幅
@property (nonatomic , assign) CGFloat volume_price; // 成交额
@property (nonatomic , assign) CGFloat volume_total; // 成交量
@property (nonatomic , assign) CGFloat yesterday_close_price;   // 昨收
@property (nonatomic , copy) NSString *date_string; // 日期

@end

NS_ASSUME_NONNULL_END

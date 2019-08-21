
//
//  PKExample1ViewController+Configuration.m
//  PKStockCharts
//
//  Created by zhanghao on 2019/7/11.
//  Copyright © 2019年 PsychokinesisTeam. All rights reserved.
//

#import "PKExample1ViewController+Configuration.h"
#import "NSDate+PKStockChart.h"

@implementation PKExample1ViewController (Configuration)

- (PKTimeChartSet *)makeOneTimeChartSet {
    PKTimeChartSet *set = [PKTimeChartSet defaultSet];
    set.chartType = PKTimeChartTypeOneDay;
    set.crossLineConstrained = NO;
    set.maxDataCount = 268;
    set.datePosition = PKChartDatePositionMiddle;
    NSMutableArray *timeSets = [NSMutableArray array];
    NSArray *arrA = [NSDate pk_minutesSetsBegin:570 end:690];
    NSArray *arrB = [NSDate pk_minutesSetsBegin:780 end:900];
    NSArray *arrC = [NSDate pk_minutesSetsBegin:905 end:930];
    [timeSets addObjectsFromArray:arrA];
    [timeSets addObjectsFromArray:arrB];
    [timeSets addObjectsFromArray:arrC];
    set.timelineAllMinutes = timeSets;
    set.timelineDisplayMinutes = @[@(570), @(630), @(690), @(840), @(900), @(930)];
    set.timelineDisplayTexts = @[@"09:30", [NSNull null], @"11:30/13:00", [NSNull null], @"15:05", @"15:30"];
//    set.gridLineWidth = 10;
//    set.gridLineColor = [UIColor blueColor];
    return set;
}

- (PKTimeChartSet *)makeFiveTimeChartSet {
    PKTimeChartSet *set = [PKTimeChartSet defaultSet];
    set.chartType = PKTimeChartTypeFiveDays;
    set.maxDataCount = 241 * 5;
    set.dateFormatter = PKChartDateFormat_Md;
    set.crossDateFormatter = PKChartDateFormat_MdHm;
    set.showFlashing = YES;
//    set.gridLineWidth = 10;
//    set.gridLineColor = [UIColor blueColor];
    return set;
}

- (PKKLineChartSet *)makeKlineChartSet {
    PKKLineChartSet *set = [PKKLineChartSet defaultSet];
//    set.datePosition = PKChartDatePositionMiddle;
//    set.numberOfVisible = 30;
//    set.shapeStrokeWidth = 0;
//    set.shouldFallSolid = NO;
//    set.shouldRiseSolid = NO;
//    set.shouldFlatSolid = NO;
//    set.shapeGap = 5;
//    set.gridLineWidth = 5;
//    set.gridLineColor = [UIColor blueColor];
    return set;
}

@end

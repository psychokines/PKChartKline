//
//  PKExample1ViewController+Configuration.h
//  PKStockCharts
//
//  Created by zhanghao on 2019/7/11.
//  Copyright © 2019年 PsychokinesisTeam. All rights reserved.
//

#import "PKExample1ViewController.h"
#import "PKTimeChart.h"
#import "PKKLineChart.h"

@interface PKExample1ViewController (Configuration)

/** 分时图样式 */
- (PKTimeChartSet *)makeOneTimeChartSet;

/** 五日分时图样式 */
- (PKTimeChartSet *)makeFiveTimeChartSet;

- (PKKLineChartSet *)makeKlineChartSet;

@end

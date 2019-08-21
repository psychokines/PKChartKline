//
//  PKTimePileIndexLayer.m
//  PKStockCharts
//
//  Created by zhanghao on 2019/8/13.
//  Copyright © 2019年 PsychokinesisTeam. All rights reserved.
//

#import "PKTimePileIndexLayer.h"

@interface PKTimePileIndexLayer ()

/** 持仓成本线 */
@property (nonatomic, strong) CAShapeLayer *indexLineLayer;

@end

@implementation PKTimePileIndexLayer

- (instancetype)init {
    if (self = [super init]) {
        [self sublayerInitialization];
    }
    return self;
}

- (void)sublayerInitialization {
    _indexLineLayer = [CAShapeLayer layer];
    _indexLineLayer.lineJoin = kCALineJoinRound;
    _indexLineLayer.lineCap = kCALineCapRound;
    [self addSublayer:_indexLineLayer];
    
    _indexLineLayer.fillColor = [UIColor clearColor].CGColor;
    _indexLineLayer.strokeColor = [UIColor redColor].CGColor;
    _indexLineLayer.lineWidth = 1;
}

- (PKChartRegionType)pileChartRegionType {
    return PKChartRegionTypeMajor;
}

- (CGPeakValue)pileChartPeakValue:(CGPeakValue)peakValue {
    return peakValue;
    CGPeakValue peak = peakValue;
    peak = CGPeakValueMake(22.7, 14.7);
    
    CGPeakValue values[] = {peakValue, peak};
    return CGPeakValueSkipZeroTraverses(values, 2);
}

- (void)pileChart {
    //    NSLog(@"dataList===> 哈哈哈%@", self.dataList);
    
    CGFloat positionCostPrice = 17.6; // position line
    if (positionCostPrice > 0 && self.indexLineLayer.lineWidth > 0) {
        [self drawHorizontalLineInLayer:self.indexLineLayer evaluatedBlock:^CGFloat{
            return positionCostPrice;
        }];
    }
}

@end

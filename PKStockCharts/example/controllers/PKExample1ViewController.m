//
//  PKExample1ViewController.m
//  PKStockCharts
//
//  Created by zhanghao on 2019/7/11.
//  Copyright © 2019年 PsychokinesisTeam. All rights reserved.
//

#import "PKExample1ViewController.h"
#import <PKCategories/PKCategories.h>
#import <Masonry/Masonry.h>
#import <MJExtension/MJExtension.h>
#import "PKSegmentedSlideControl.h"
#import "PKExample1ViewController+Configuration.h"
#import "PKStockObjects.h"
#import "PKTimePileTapeLayer.h"
#import "PKTimePileIndexLayer.h"

@interface PKExample1ViewController () <PKTimeChartDelegate, PKKLineChartDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) PKSegmentedSlideControl *segmentedControl;
@property (nonatomic, strong) PKTimeChart *timeChart;
@property (nonatomic, strong) PKKLineChart *KlineChart;
@property (nonatomic, strong) PKTimePileTapeLayer *lap;

@end

@implementation PKExample1ViewController

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    UIButton *buttonA = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonA.backgroundColor = [UIColor yellowColor];
    [buttonA setTitle:@"doLeft" forState:UIControlStateNormal];
    [buttonA setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    buttonA.frame = CGRectMake(50, 500, 100, 50);
    [buttonA addTarget:self action:@selector(doLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonA];
    
    UIButton *buttonB = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonB.backgroundColor = [UIColor yellowColor];
    [buttonB setTitle:@"doRight" forState:UIControlStateNormal];
    [buttonB setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonB addTarget:self action:@selector(doRight) forControlEvents:UIControlEventTouchUpInside];
    buttonB.frame = CGRectMake(250, 500, 100, 50);
    [self.view addSubview:buttonB];
    
    [self commonInitialization];
    [self layoutInitialization];
    [self dataInitialization];
}

- (void)doLeft {
    self.pk_statusBarStyle = UIStatusBarStyleLightContent;
    [self.KlineChart slideToLeftOnce];
//    [self.KlineChart doSmallScaleOnce];
}

- (void)doRight {
    [self.KlineChart slideToRightOnce];
//    [self.KlineChart doLargeScaleOnce];
    
    self.pk_statusBarStyle = UIStatusBarStyleDefault;
}

- (void)commonInitialization {
    NSArray<NSString *> *titles = @[@"分时", @"五日", @"日K", @"周K", @"年K"];
    _segmentedControl = [[PKSegmentedSlideControl alloc] initWithTitles:titles];
    _segmentedControl.normalTextColor = [UIColor blackColor];
    _segmentedControl.selectedTextColor = [UIColor pk_colorWithRed:40 green:163 blue:239];
    _segmentedControl.plainTextFont = [UIFont fontWithName:@"Avenir" size:17.0];
    _segmentedControl.backgroundColor = [UIColor whiteColor];
    _segmentedControl.indicatorLineWidth = 4;
    _segmentedControl.paddingInset = 15;
    _segmentedControl.innerSpacing = 5;
    _segmentedControl.numberOfPageItems = titles.count;
    _segmentedControl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    _segmentedControl.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    [_segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [_segmentedControl setWithIndex:2 animated:NO];
    [self.view addSubview:_segmentedControl];
    
    _timeChart = [PKTimeChart new];
    _timeChart.delegate = self;
    _timeChart.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_timeChart];
    
    _KlineChart = [PKKLineChart new];
    _KlineChart.delegate = self;
    _KlineChart.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_KlineChart];
    
    NSArray *majorIndicators = @[PKIndicatorMA];
    for (NSString *identifier in majorIndicators) {
        [_KlineChart registerClass:NSClassFromString(identifier) forIndicatorIdentifier:identifier];
    }
    NSArray *minorIndicators = @[PKIndicatorVOL, PKIndicatorBOLL, PKIndicatorMACD, PKIndicatorKDJ];
    for (NSString *identifier in minorIndicators) {
        [_KlineChart registerClass:NSClassFromString(identifier) forIndicatorIdentifier:identifier];
    }
    _KlineChart.defaultMajorIndicatorIdentifier = PKIndicatorMA;
    _KlineChart.defaultMinorIndicatorIdentifier = PKIndicatorVOL;
}

- (void)layoutInitialization {
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(5);
        make.right.equalTo(self.view).offset(-5);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.timeChart mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.segmentedControl);
        make.left.mas_equalTo(10);
        make.right.equalTo(self.view).mas_offset(-10);
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.height.mas_equalTo(290);
    }];
    
    [self.KlineChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.timeChart);
    }];
}

- (void)dataInitialization {
    [self valueChanged:_segmentedControl];
}

- (void)valueChanged:(PKSegmentedSlideControl *)sender {
    NSLog(@"The selected index is: %@", @(sender.index));
    __weak typeof(self) weakSelf = self;
    
    switch (sender.index) {
        case 0: { // 分时
            [self.view bringSubviewToFront:self.timeChart];
            [self.timeChart clearChart];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSString *jsonPath = [NSBundle pk_mainBundleWithName:@"time_chart_data.json"];
                NSString *jsonStriing = [[NSString alloc]initWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
                NSArray *array = [NSArray pk_arrayWithJSONString:jsonStriing];
                NSArray<PKTimeItem *> *models = [PKTimeItem mj_objectArrayWithKeyValuesArray:array];
                weakSelf.timeChart.dataList = models;
                weakSelf.timeChart.coordObj = models.firstObject;
                weakSelf.timeChart.set = [self makeOneTimeChartSet];
                
                self->_lap = [PKTimePileTapeLayer layer];
                [weakSelf.timeChart pileChartLayer:self-> _lap forIdentifier:@"ksdf"];
                PKTimePileIndexLayer *lab2 = [PKTimePileIndexLayer layer];
                [weakSelf.timeChart pileChartLayer:lab2 forIdentifier:@"dsfbbb"];
                [weakSelf.timeChart drawChart];
            });
            
        } break;
        case 1: { // 五日
            [self.view bringSubviewToFront:self.timeChart];
//            [self.timeChart cleanChart];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSString *jsonPath = [NSBundle pk_mainBundleWithName:@"600887_five_day.json"];
                NSString *jsonStriing = [[NSString alloc]initWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
                NSArray *array = [NSArray pk_arrayWithJSONString:jsonStriing];
                NSArray<PKTimeItem *> *models = [PKTimeItem mj_objectArrayWithKeyValuesArray:array];
                weakSelf.timeChart.dataList = models;
                weakSelf.timeChart.set = [self makeFiveTimeChartSet];
                [weakSelf.timeChart drawChart];
            });
            
        } break;
            
        case 2: {
            [self.view bringSubviewToFront:self.KlineChart];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSString *path = [NSBundle pk_mainBundleWithName:@"yl_kline_data.plist"];
                NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
                NSArray *results = [dictionary objectForKey:@"results"];
                NSArray<PKKlineItem *> *items = [PKKlineItem mj_objectArrayWithKeyValuesArray:results];
                weakSelf.KlineChart.set = [self makeKlineChartSet];
                weakSelf.KlineChart.dataList = items;
                [weakSelf.KlineChart drawChart];
            });

        } break;
            
        case 3: {
            [self.KlineChart clearChart];
            [self.view bringSubviewToFront:self.KlineChart];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSString *path = [NSBundle pk_mainBundleWithName:@"yl_kline_data.plist"];
                NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
                NSArray *results = [dictionary objectForKey:@"results"];
                NSArray<PKKlineItem *> *items = [PKKlineItem mj_objectArrayWithKeyValuesArray:results];
                weakSelf.KlineChart.set = [self makeKlineChartSet];
                weakSelf.KlineChart.dataList = items;
                [weakSelf.KlineChart drawChart];
            });
        } break;
            
        default: break;
    }
}

#pragma mark - PKTimeChartDelegate

/** 图表单击时回调 (若isMajorRange为YES则点击了主图区域，NO为副图区域) */
- (void)timeChart:(PKTimeChart *)timeChart didSingleTapAtMajorRange:(BOOL)isMajorRange {
    NSLog(@"didSingleTapAtMajorRange - %@", @(isMajorRange));
}

/** 图表双击时回调 (若isMajorRange为YES则双击了主图区域，NO为副图区域) */
- (void)timeChart:(PKTimeChart *)timeChart didDoubleTapAtMajorRange:(BOOL)isMajorRange {
     NSLog(@"didDoubleTapAtMajorRange - %@", @(isMajorRange));
}

/** 图表将要长按时回调 */
- (void)timeChartWillLongPress:(PKTimeChart *)timeChart {
    NSLog(@"timeChartWillLongPress");
}

/** 图表正在长按中 (index为当前点对应在数组中的索引) */
- (void)timeChart:(PKTimeChart *)timeChart didLongPressAtCorrespondIndex:(NSInteger)index {
//    NSLog(@"didLongPressAtCorrespondIndex - %@", @(index));
}

/** 图表长按结束时回调 */
- (void)timeChartEndLongPress:(PKTimeChart *)timeChart {
    NSLog(@"timeChartEndLongPress");
}

/** 图表十字线消失时回调 */
- (void)timeChartCrossLineDidDismiss:(PKTimeChart *)timeChart {
    NSLog(@"timeChartCrossLineDidDismiss");
}

#pragma mark - PKKLineChartDelegate

- (void)klineChart:(PKKLineChart *)klineChart didTooltipAtCorrespondIndex:(NSInteger)index {
    NSLog(@"didTooltipAtCorrespondIndex==> %@", @(index));
}

- (void)klineChartCrossLineDidDismiss:(PKKLineChart *)klineChart {
    NSLog(@"klineChartCrossLineDidDismiss");
}

- (void)dealloc {
    NSLog(@"NSStringFromClass===>✈️ %@", NSStringFromClass(self.class));
}

@end

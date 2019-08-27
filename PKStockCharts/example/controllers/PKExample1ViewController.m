//
//  PKExample1ViewController.m
//  PKStockCharts
//
//  Created by zhanghao on 2019/7/11.
//  Copyright © 2019年 PsychokinesisTeam. All rights reserved.
//

#import "PKExample1ViewController.h"
#import "PKLandscapeViewController.h"

@interface PKExample1ViewController ()

@end

@implementation PKExample1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];

    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"点击横屏" style:UIBarButtonItemStylePlain target:self action:@selector(present)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)present {
    PKLandscapeViewController *vc = [[PKLandscapeViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end

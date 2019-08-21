//
//  UIApplication+PKExtend.h
//  PKCategories
//
//  Created by jiaohong on 2018/11/21.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (PKExtend)

/** 获取当前程序的Window */
- (nullable UIWindow *)pk_frontWindow;

/** 获取顶层视图控制器 */
- (nullable UIViewController *)pk_frontViewController;

@end

NS_ASSUME_NONNULL_END

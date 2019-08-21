//
//  UIScreen+PKExtend.h
//  PKCategories
//
//  Created by jiaohong on 2018/10/28.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (PKExtend)

@property (class, nonatomic, assign, readonly) CGFloat pk_scale;
@property (class, nonatomic, assign, readonly) CGSize pk_size;
@property (class, nonatomic, assign, readonly) CGFloat pk_width;
@property (class, nonatomic, assign, readonly) CGFloat pk_height;
@property (class, nonatomic, assign, readonly) CGSize pk_swapSize;
@property (class, nonatomic, assign, readonly) UIEdgeInsets pk_safeInsets; // 竖屏模式下

@end

NS_ASSUME_NONNULL_END

//
//  UIButton+PKExtend.h
//  PKCategories
//
//  Created by zhanghao on 2018/10/30.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PKButtonImagePosition) {
    PKButtonImagePositionLeft = 0,    // 图片在左，文字在右
    PKButtonImagePositionRight,       // 图片在右，文字在左
    PKButtonImagePositionTop,         // 图片在上，文字在下
    PKButtonImagePositionBottom,      // 图片在下，文字在上
};

@interface UIButton (PKExtend)

/**
 *  调整UIButton的文字和图片之间的位置及间距(不能调整内部imageView尺寸)
 *  注：设置图片和文字后调用才会有效，且button的尺寸要大于 > 图片大小+文字大小+spacing
 */
- (void)pk_updateImagePosition:(PKButtonImagePosition)postion spacing:(CGFloat)spacing;

@end


@interface UIButton (PKIndicator)

/**
 *  显示活动指示器UIActivityIndicatorView (活动指示器显示时图片标题将置空，指示器消失则恢复)
 */
- (void)pk_showIndicator;

/**
 *  @brief 显示活动指示器和文本
 *
 *  @param text 自定义文本
 */
- (void)pk_showIndicatorWithText:(NSString *)text;

/**
 *  @brief 显示活动指示器 (背景色将置空，活动指示器消失则恢复)
 *
 *  @param tintColor 设置活动指示器颜色
 */
- (void)pk_showClearIndicatorWithTintColor:(nullable UIColor *)tintColor;

/** 隐藏活动指示器 */
- (void)pk_hideIndicator;

/** 判断活动指示器是否正在显示 */
@property (nonatomic, assign, readonly) BOOL pk_isIndicatorShowing;

@end

NS_ASSUME_NONNULL_END

//
//  UIScrollView+PKExtend.h
//  PKCategories
//
//  Created by jiaohong on 2018/10/29.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (PKExtend)

/** 使视图滚动到顶部 */
- (void)pk_scrollToTop;

/** 使视图滚动到底部 */
- (void)pk_scrollToBottom;

/** 使视图滚动到左部 */
- (void)pk_scrollToLeft;

/** 使视图滚动到右部 */
- (void)pk_scrollToRight;

- (void)pk_scrollToTopAnimated:(BOOL)animated;
- (void)pk_scrollToBottomAnimated:(BOOL)animated;
- (void)pk_scrollToLeftAnimated:(BOOL)animated;
- (void)pk_scrollToRightAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END

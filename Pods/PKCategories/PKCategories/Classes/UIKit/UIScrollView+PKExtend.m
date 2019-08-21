//
//  UIScrollView+PKExtend.m
//  PKCategories
//
//  Created by jiaohong on 2018/10/29.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import "UIScrollView+PKExtend.h"

@implementation UIScrollView (PKExtend)

- (void)pk_scrollToTop {
    [self pk_scrollToTopAnimated:YES];
}

- (void)pk_scrollToBottom {
    [self pk_scrollToBottomAnimated:YES];
}

- (void)pk_scrollToLeft {
    [self pk_scrollToLeftAnimated:YES];
}

- (void)pk_scrollToRight {
    [self pk_scrollToRightAnimated:YES];
}

- (void)pk_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)pk_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)pk_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)pk_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end

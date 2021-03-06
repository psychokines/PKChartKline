//
//  UIButton+PKExtend.m
//  PKCategories
//
//  Created by zhanghao on 2018/10/30.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import "UIButton+PKExtend.h"
#import <objc/runtime.h>

@implementation UIButton (PKExtend)

- (void)pk_updateImagePosition:(PKButtonImagePosition)postion spacing:(CGFloat)spacing {
    CGSize imageSize = self.imageView.image.size;
    CGSize labelSize = self.titleLabel.intrinsicContentSize;
    
    switch (postion) {
        case PKButtonImagePositionLeft: {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, - spacing / 2, 0, spacing / 2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, - spacing / 2);
        } break;
            
        case PKButtonImagePositionRight: {
            CGFloat imageOffset = labelSize.width + spacing / 2;
            CGFloat titleOffset = imageSize.width + spacing / 2;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, imageOffset, 0, - imageOffset);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - titleOffset, 0, titleOffset);
        } break;
            
        case PKButtonImagePositionTop: {
            self.imageEdgeInsets = UIEdgeInsetsMake(-labelSize.height - spacing, 0, 0, -labelSize.width);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -imageSize.height - spacing, 0);
        } break;
            
        case PKButtonImagePositionBottom: {
            self.imageEdgeInsets = UIEdgeInsetsMake(labelSize.height + spacing, 0, 0, -labelSize.width);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, imageSize.height + spacing, 0);
        } break;
            
        default: break;
    }
}

@end


static void *UIButtonAssociatedPKIndicatorViewKey = &UIButtonAssociatedPKIndicatorViewKey;
static void *UIButtonAssociatedPKNormalTitleKey = &UIButtonAssociatedPKNormalTitleKey;
static void *UIButtonAssociatedPKNormalImageKey = &UIButtonAssociatedPKNormalImageKey;
static void *UIButtonAssociatedPKTitleEdgeInsetsKey = &UIButtonAssociatedPKTitleEdgeInsetsKey;
static void *UIButtonAssociatedPKBackgroundColorKey = &UIButtonAssociatedPKBackgroundColorKey;

@implementation UIButton (PKIndicator)

- (BOOL)pk_isIndicatorShowing {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setPk_isIndicatorShowing:(BOOL)pk_isIndicatorShowing {
    objc_setAssociatedObject(self, @selector(pk_isIndicatorShowing), @(pk_isIndicatorShowing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)pk_showIndicator {
    return [self pk_showIndicatorWithTintColor:[UIColor whiteColor] backClear:NO];
}

- (void)pk_showClearIndicatorWithTintColor:(UIColor *)tintColor {
    return [self pk_showIndicatorWithTintColor:tintColor backClear:YES];
}

- (void)pk_showIndicatorWithTintColor:(UIColor *)tintColor backClear:(BOOL)isClear {
    if (self.pk_isIndicatorShowing) return;
    
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        [self.superview layoutIfNeeded];
    }
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    indicator.color = tintColor;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    indicator.transform = transform;
    objc_setAssociatedObject(self, UIButtonAssociatedPKIndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (isClear) {
        UIColor *currentBackgroundColor = self.backgroundColor;
        objc_setAssociatedObject(self, UIButtonAssociatedPKBackgroundColorKey, currentBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.backgroundColor = [UIColor clearColor];
    }
    
    NSString *buttonTitle = [self titleForState:UIControlStateNormal];
    UIImage *buttonImage = [self imageForState:UIControlStateNormal];
    objc_setAssociatedObject(self, UIButtonAssociatedPKNormalTitleKey, buttonTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, UIButtonAssociatedPKNormalImageKey, buttonImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateNormal];
    self.userInteractionEnabled = NO;
    
    [indicator startAnimating];
    [self addSubview:indicator];
    self.pk_isIndicatorShowing = YES;
}

- (void)pk_showIndicatorWithText:(NSString *)text {
    if (self.pk_isIndicatorShowing) return;
    
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        [self.superview layoutIfNeeded];
    }
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.color = [UIColor whiteColor];
    objc_setAssociatedObject(self, UIButtonAssociatedPKIndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSString *buttonTitle = [self titleForState:UIControlStateNormal];
    UIImage *buttonImage = [self imageForState:UIControlStateNormal];
    objc_setAssociatedObject(self, UIButtonAssociatedPKNormalTitleKey, buttonTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, UIButtonAssociatedPKNormalImageKey, buttonImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitle:text forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateNormal];
    self.userInteractionEnabled = NO;
    
    CGFloat spacing = 15;
    CGSize size = [self.titleLabel sizeThatFits:self.bounds.size];
    CGFloat padding = (self.bounds.size.width - size.width) / 2;
    CGFloat offset = (self.bounds.size.width - indicator.bounds.size.width - size.width - spacing) / 2;
    indicator.center = CGPointMake(offset + indicator.bounds.size.width / 2, self.bounds.size.height / 2);
    NSValue *value = [NSValue valueWithUIEdgeInsets:self.titleEdgeInsets];
    objc_setAssociatedObject(self, UIButtonAssociatedPKTitleEdgeInsetsKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, padding, 0, -padding + offset * 2);
    
    [indicator startAnimating];
    [self addSubview:indicator];
    self.pk_isIndicatorShowing = YES;
}

- (void)pk_hideIndicator {
    if (!self.pk_isIndicatorShowing) return;
    
    id object = objc_getAssociatedObject(self, UIButtonAssociatedPKBackgroundColorKey);
    if (object) {
        self.backgroundColor = (UIColor *)object;
    }
    
    NSValue *value = objc_getAssociatedObject(self, UIButtonAssociatedPKTitleEdgeInsetsKey);
    if (value) {
        UIEdgeInsets titleEdgeInsets = [value UIEdgeInsetsValue];
        self.titleEdgeInsets = titleEdgeInsets;
    }
    
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, UIButtonAssociatedPKIndicatorViewKey);
    if (!indicator) return;
    [indicator stopAnimating];
    [indicator removeFromSuperview];
    
    NSString *buttonTitle = (NSString *)objc_getAssociatedObject(self, UIButtonAssociatedPKNormalTitleKey);
    [self setTitle:buttonTitle forState:UIControlStateNormal];
    UIImage *buttonImage = (UIImage *)objc_getAssociatedObject(self, UIButtonAssociatedPKNormalImageKey);
    [self setImage:buttonImage forState:UIControlStateNormal];
    self.userInteractionEnabled = YES;
    self.pk_isIndicatorShowing = NO;
    
    objc_setAssociatedObject(self, UIButtonAssociatedPKIndicatorViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, UIButtonAssociatedPKBackgroundColorKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, UIButtonAssociatedPKNormalTitleKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, UIButtonAssociatedPKNormalImageKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, UIButtonAssociatedPKTitleEdgeInsetsKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

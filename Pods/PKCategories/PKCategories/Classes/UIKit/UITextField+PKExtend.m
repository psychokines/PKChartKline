//
//  UITextField+PKExtend.m
//  PKCategories
//
//  Created by jiaohong on 2018/10/29.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import "UITextField+PKExtend.h"
#import <objc/runtime.h>

@implementation UITextField (PKExtend)

+ (void)load {
    SEL selectors[] = {
        @selector(placeholderRectForBounds:),
        @selector(textRectForBounds:),
        @selector(editingRectForBounds:)
    };
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"_pk_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (CGRect)_pk_placeholderRectForBounds:(CGRect)bounds {
    [self _pk_placeholderRectForBounds:bounds];
    return UIEdgeInsetsInsetRect(bounds, self.pk_placeHolderEdgeInsets);
}

- (CGRect)_pk_textRectForBounds:(CGRect)bounds {
    CGRect rect = [self _pk_textRectForBounds:bounds];
    return UIEdgeInsetsInsetRect(rect, self.pk_textEdgeInsets);
}

- (CGRect)_pk_editingRectForBounds:(CGRect)bounds {
    CGRect rect = [self _pk_textRectForBounds:bounds];
    return UIEdgeInsetsInsetRect(rect, self.pk_textEdgeInsets);
}

- (UIEdgeInsets)pk_textEdgeInsets {
    return [objc_getAssociatedObject(self, _cmd) UIEdgeInsetsValue];
}

- (void)setPk_textEdgeInsets:(UIEdgeInsets)pk_textEdgeInsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:pk_textEdgeInsets];
    objc_setAssociatedObject(self, @selector(pk_textEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)pk_placeHolderEdgeInsets {
    return [objc_getAssociatedObject(self, _cmd) UIEdgeInsetsValue];
}

- (void)setPk_placeHolderEdgeInsets:(UIEdgeInsets)pk_placeHolderEdgeInsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:pk_placeHolderEdgeInsets];
    objc_setAssociatedObject(self, @selector(pk_placeHolderEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)pk_selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)pk_setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

@end

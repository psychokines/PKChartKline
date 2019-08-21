//
//  UINavigationBar+PKExtend.m
//  PKCategories
//
//  Created by jiaohong on 2018/10/28.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import "UINavigationBar+PKExtend.h"

@implementation UINavigationBar (PKExtend)

- (UIFont *)pk_titleFont {
    id value = [self.titleTextAttributes objectForKey:NSFontAttributeName];
    if ([value isKindOfClass:[UIFont class]]) return (UIFont *)value;
    return nil;
}

- (void)setPk_titleFont:(UIFont *)pk_titleFont {
    NSDictionary *originAttributes = [self titleTextAttributes];
    NSMutableDictionary *textAttributes = originAttributes ? originAttributes.mutableCopy : @{}.mutableCopy;
    if (pk_titleFont) textAttributes[NSFontAttributeName] = pk_titleFont;
    self.titleTextAttributes = textAttributes;
}

- (UIColor *)pk_titleColor {
    id value = [self.titleTextAttributes objectForKey:NSForegroundColorAttributeName];
    if ([value isKindOfClass:[UIColor class]]) return (UIColor *)value;
    return nil;
}

- (void)setPk_titleColor:(UIColor *)pk_titleColor {
    NSDictionary *originAttributes = [self titleTextAttributes];
    NSMutableDictionary *textAttributes = originAttributes ? originAttributes.mutableCopy : @{}.mutableCopy;
    if (pk_titleColor) textAttributes[NSForegroundColorAttributeName] = pk_titleColor;
    self.titleTextAttributes = textAttributes;
}

@end

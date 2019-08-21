//
//  UIScreen+PKExtend.m
//  PKCategories
//
//  Created by jiaohong on 2018/10/28.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import "UIScreen+PKExtend.h"
#import "UIApplication+PKExtend.h"

@implementation UIScreen (PKExtend)

+ (CGFloat)pk_scale {
    static CGFloat screenScale = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSThread isMainThread]) {
            screenScale = [[UIScreen mainScreen] scale];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                screenScale = [[UIScreen mainScreen] scale];
            });
        }
    });
    return screenScale;
}

+ (CGSize)pk_size {
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)pk_width {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)pk_height {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGSize)pk_swapSize {
    return CGSizeMake(self.pk_size.height, self.pk_size.width);
}

+ (UIEdgeInsets)pk_safeInsets {
    if (@available(iOS 11.0, *)) {
        return [UIApplication.sharedApplication pk_frontWindow].safeAreaInsets;
    }
    return UIEdgeInsetsMake(20, 0, 0, 0);
}

@end

//
//  UIApplication+PKExtend.m
//  PKCategories
//
//  Created by jiaohong on 2018/11/21.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import "UIApplication+PKExtend.h"

@implementation UIApplication (PKExtend)

- (UIWindow *)pk_frontWindow {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (keyWindow) return keyWindow;
    NSEnumerator *enumerator = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in enumerator) {
        BOOL isVisible = !window.isHidden && window.alpha > 0;
        BOOL isOnMainScreen = (window.screen == [UIScreen mainScreen]);
        if (isVisible && isOnMainScreen && window.isKeyWindow) {
            return window;
        }
    }
    return [[UIApplication sharedApplication].delegate window];
}

- (UIViewController *)pk_frontViewController {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *resultViewController = [window rootViewController];
    UIViewController *parent = resultViewController;
    while ((parent = resultViewController.presentedViewController) != nil ) {
        resultViewController = parent;
    }
    while ([resultViewController isKindOfClass:[UINavigationController class]]) {
        resultViewController = [(UINavigationController *)resultViewController topViewController];
    }
    return resultViewController;
}

@end

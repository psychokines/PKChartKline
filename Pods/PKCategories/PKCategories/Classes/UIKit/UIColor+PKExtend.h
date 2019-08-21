//
//  UIColor+PKExtend.h
//  PKCategories
//
//  Created by zhanghao on 2018/10/28.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (PKExtend)

+ (UIColor *)pk_colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;
+ (UIColor *)pk_colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;
+ (UIColor *)pk_colorWithRGBA:(NSUInteger)rgbaValue;
+ (UIColor *)pk_colorWithRGB:(NSUInteger)rgbValue;
- (NSUInteger)pk_RGBAValue;
- (NSUInteger)pk_RGBValue;
- (NSArray<NSNumber *> *)pk_RGBAValues;

/** 系统蓝 */
+ (UIColor *)pk_systemBlueColor;

/** 分隔线颜色 */
+ (UIColor *)pk_separatorLineColor;

/** 随机色 */
+ (UIColor *)pk_randomColor;

/** 十六进制颜色值转RGB颜色 */
+ (nullable UIColor *)pk_colorWithHexString:(NSString *)hexString;

/** 返回颜色的RGB值对应的十六进制字符串 */
- (nullable NSString *)pk_hexString;

/** 返回颜色的RGBA值对应的十六进制字符串 */
- (nullable NSString *)pk_hexStringWithAlpha;

/** 获取颜色的alpha值 (取值0.0~1.0) */
@property (nonatomic, assign, readonly) CGFloat pk_alphaValue;

@end

NS_ASSUME_NONNULL_END

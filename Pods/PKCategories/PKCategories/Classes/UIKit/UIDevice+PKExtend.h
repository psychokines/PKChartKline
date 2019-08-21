//
//  UIDevice+PKExtend.h
//  PKCategories
//
//  Created by jiaohong on 2018/10/29.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (PKExtend)

/**
 * 判断当前屏幕是否为iphone4/4s尺寸屏
 *
 * @return BOOL类型YES or NO.
 */
- (BOOL)pk_isIPhone4;

/** 判断当前屏幕是否为iphone5/5c/5s/SE尺寸屏 */
- (BOOL)pk_isIPhone5;

/** 判断当前屏幕是否为iphone6/6s/7/8尺寸屏 */
- (BOOL)pk_isIPhone6;

/** 判断当前屏幕是否为iphone6p/6sp/7p/8p尺寸屏 */
- (BOOL)pk_isIPhone6p;

/** 判断当前屏幕是否为iphoneX/XS尺寸屏 */
- (BOOL)pk_isIPhoneX;

/** 判断当前屏幕是否为iPhoneXR尺寸屏 */
- (BOOL)pk_isIPhoneXR;

/** 判断当前屏幕是否为iPhoneXSMax尺寸屏 */
- (BOOL)pk_isIPhoneXsMax;

/** 判断当前设备是否为刘海屏 (iphoneX/XS/XR/XSMax) */
- (BOOL)pk_isBangsScreen;

/** 获取当前设备的系统版本 */
@property (nonatomic, assign, readonly, class) double pk_systemVersion;

/** 获取当前设备的名称 (e.g. "My iPhone") */
@property (nonatomic, readonly, class) NSString *pk_deviceName;

/** 判断设备是否为模拟器 */
@property (nonatomic, assign, readonly) BOOL pk_isSimulator;

/** 判断设备是否为iPad */
@property (nonatomic, assign, readonly) BOOL pk_isPad;

/** 获取设备的WIFI-IP地址 (e.g. "192.168.1.111") */
@property (nonatomic, readonly, nullable) NSString *pk_ipAddressWIFI;

/** 获取设备的单元IP地址 (e.g. "10.2.2.222") */
@property (nonatomic, readonly, nullable) NSString *pk_ipAddressCell;

/** 判断当前设置是否有摄像头 */
@property (nonatomic, assign, class, readonly) BOOL pk_hasCamera;

/** 获取手机机型对应名称 */
@property (nonatomic, readonly, class, nullable) NSString *pk_machineName;

/** 获取手机内存总量 (单位：字节数) */
+ (NSUInteger)pk_totalMemoryBytes;

/** 获取手机可用内存 (单位：字节数) */
+ (NSUInteger)pk_freeMemoryBytes;

@end

NS_ASSUME_NONNULL_END

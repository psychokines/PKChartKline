//
//  UITextField+PKExtend.h
//  PKCategories
//
//  Created by jiaohong on 2018/10/29.
//  Copyright © 2018年 PsychokinesisTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (PKExtend)

/** 调整文本内边距 */
@property (nonatomic, assign) UIEdgeInsets pk_textEdgeInsets;

/** 调整占位符文本内边距 */
@property (nonatomic, assign) UIEdgeInsets pk_placeHolderEdgeInsets;

/** 选定所有文本 */
- (void)pk_selectAllText;

/** 选定某范围内的文本 */
- (void)pk_setSelectedRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END

//
//  BulletConfigure.h
//  commentDemo
//
//  Created by wemac on 2020/3/1.
//  Copyright © 2020 wemac. All rights reserved.
//
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BulletConfigure : NSObject
/** 类方法创建 */
+ (instancetype)bulletConfigure;
/** 标题文字字号大小，默认 15 号字体 */
@property (nonatomic, strong) UIFont *titleFont;
/** 普通状态下标题按钮文字的颜色，默认为白色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 背景色数组 默认为红色 */
@property (nonatomic, strong) NSMutableArray<UIColor *> *bgColors;
/** 弹幕高度，默认为 30.0f */
@property (nonatomic, assign) CGFloat bulletHeight;
/** 弹幕时间，默认为 4.0f */
@property (nonatomic, assign) CGFloat bulletDuration;
/** 弹幕圆角，默认为 5 */
@property (nonatomic, assign) CGFloat bulletCornerRadius;
/** 弹道条数，默认为 3  区间3-10*/
@property (nonatomic, assign) CGFloat bulletTrajectorys;



@end

NS_ASSUME_NONNULL_END

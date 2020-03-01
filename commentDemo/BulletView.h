//
//  BulletView.h
//  commentDemo
//
//  Created by wemac on 2020/2/29.
//  Copyright © 2020 wemac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BulletConfigure;
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    bulletStar, //开始移动
    bulletEnter, //完全进入
    bulletEnd,  //完全移出
} moveStatus;
@interface BulletView : UIView

/// 弹道
@property (nonatomic,assign) int  trajectory;
/// 弹道状态回调
@property (nonatomic,copy) void(^moveStatusBlock)(moveStatus status);

- (instancetype)initWithComment:(NSString *)comment configure:(BulletConfigure *)configure;
- (void)startA;
- (void)stopA;

@end

NS_ASSUME_NONNULL_END

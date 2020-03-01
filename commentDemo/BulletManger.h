//
//  BulletManger.h
//  commentDemo
//
//  Created by wemac on 2020/2/29.
//  Copyright © 2020 wemac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BulletView;
@class BulletConfigure;
NS_ASSUME_NONNULL_BEGIN

@interface BulletManger : NSObject
@property (nonatomic,strong) NSMutableArray *BullDataSouce;
@property (nonatomic,copy) void(^generateViewBlock)(BulletView *view);

- (instancetype)initWithConfigure:(BulletConfigure *)configure;

/// 弹幕开始
- (void)start;
/// 弹幕结束
- (void)stop;

@end

NS_ASSUME_NONNULL_END

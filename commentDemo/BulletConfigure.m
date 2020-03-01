//
//  BulletConfigure.m
//  commentDemo
//
//  Created by wemac on 2020/3/1.
//  Copyright © 2020 wemac. All rights reserved.
//

#import "BulletConfigure.h"

@implementation BulletConfigure

+ (instancetype)bulletConfigure {
    return [[self alloc] init];
}

- (UIFont *)titleFont {
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:15];
    }
    return _titleFont;
}

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor whiteColor];
    }
    return _titleColor;
}

- (NSMutableArray *)bgColors {
    if (!_bgColors) {
        _bgColors = [[NSMutableArray alloc]initWithObjects:[UIColor redColor], nil];
    }
    return _bgColors;
}

- (CGFloat)bulletHeight {
    if (_bulletHeight <= 0) {
        _bulletHeight = 30.0f;
    }
    return _bulletHeight;
}

- (CGFloat)bulletDuration {
    if (!_bulletDuration) {
        _bulletDuration = 4.0f;
    }
    return _bulletDuration;
}
- (CGFloat)bulletCornerRadius {
    if (!_bulletCornerRadius) {
        _bulletCornerRadius = 5.0f;
    }
    return _bulletCornerRadius;
}
- (CGFloat)bulletTrajectorys {
    if (!_bulletTrajectorys) {
        _bulletTrajectorys = 3;
    }
    return _bulletTrajectorys;
}
@end

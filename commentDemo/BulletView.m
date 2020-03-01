//
//  BulletView.m
//  commentDemo
//
//  Created by wemac on 2020/2/29.
//  Copyright © 2020 wemac. All rights reserved.
//

#import "BulletView.h"
#import "BulletConfigure.h"
#define Padding 10
@interface BulletView ()

@property (nonatomic,strong)UILabel *lbComment;
@property (nonatomic,strong)UIImageView *handImage;
@property (nonatomic,strong)BulletConfigure *configure;

@end

@implementation BulletView

- (instancetype)initWithComment:(NSString *)comment configure:(nonnull BulletConfigure *)configure{
    if (self == [super init]){
        self.configure = configure;

        self.backgroundColor = self.configure.bgColors[arc4random()%self.configure.bgColors.count];

        NSDictionary *attr = @{NSFontAttributeName:configure.titleFont};
        CGFloat commentW = [comment sizeWithAttributes:attr].width;
        self.lbComment.text = comment;
        self.bounds = CGRectMake(0, 0, commentW+2*Padding, self.configure.bulletHeight);
        self.lbComment.frame = CGRectMake(Padding, 0, commentW, self.configure.bulletHeight);
        
        self.layer.cornerRadius = self.configure.bulletCornerRadius;
        self.layer.masksToBounds = YES;
    }
    return self;
}
/// 开始动画
- (void)startA{
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = self.configure.bulletDuration;  //动画时间
    CGFloat wholeW = screenW + CGRectGetWidth(self.bounds); //动画距离
    
    if (self.moveStatusBlock){
        self.moveStatusBlock(bulletStar);
    }
    
    //计算多久 弹幕 是完全进入了 屏幕
    
    CGFloat speed = wholeW/duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;
    [self performSelector:@selector(enterBlock) withObject:nil afterDelay:enterDuration];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect frame = self.frame;
        frame.origin.x -= wholeW;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.moveStatusBlock){
            self.moveStatusBlock(bulletEnd);
        }
    }];
}
- (void)enterBlock{
    if (self.moveStatusBlock){
        self.moveStatusBlock(bulletEnter);
    }
}
/// 结束动画
- (void)stopA{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}
- (UILabel *)lbComment{
    if (!_lbComment){
        _lbComment = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbComment.font = self.configure.titleFont;
        _lbComment.textColor = self.configure.titleColor;
        _lbComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbComment];
        
    }
    
    return _lbComment;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

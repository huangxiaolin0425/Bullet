//
//  BulletManger.m
//  commentDemo
//
//  Created by wemac on 2020/2/29.
//  Copyright © 2020 wemac. All rights reserved.
//

#import "BulletManger.h"
#import "BulletView.h"
#import "BulletConfigure.h"
@interface BulletManger()
@property (nonatomic,strong)BulletConfigure *configure;

//弹幕的数据来源
@property (nonatomic,strong) NSMutableArray *dataSource;
//弹幕使用过程中的数据变量
@property (nonatomic,strong) NSMutableArray *bulletComments;
//储存弹幕view的数据变量
@property (nonatomic,strong) NSMutableArray *bulletViews;

@property BOOL stopA;
@end
@implementation BulletManger

- (instancetype)initWithConfigure:(BulletConfigure *)configure{
    if (self == [super init]){
        self.stopA = YES;
        self.configure = configure;
    }
    
    return self;
}
- (void)start{
    if (!self.stopA){
        return;
    }
    self.stopA = NO;
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.dataSource];
    
    [self initBulletComment];
}
- (void)stop{
    if (self.stopA){
        return;
    }
    self.stopA = YES;
    
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView *view = obj;
        [view stopA];
        view = nil;
        
    }];
    [self.bulletViews removeAllObjects];
}
/// 初始化 弹幕 随机分配弹道轨迹
- (void)initBulletComment{
    
    NSMutableArray *trajectorys =
    [[NSMutableArray alloc]initWithCapacity:0];
    
    if (self.configure.bulletTrajectorys > 10){
        self.configure.bulletTrajectorys = 10;
    }else if (self.configure.bulletTrajectorys < 3){
        self.configure.bulletTrajectorys = 3;
    }
    
    if (self.configure.bulletTrajectorys > self.bulletComments.count){
        self.configure.bulletTrajectorys = self.bulletComments.count;
    }
    for (int i=0; i<self.configure.bulletTrajectorys; i++) {
        [trajectorys addObject:@(i)];
    }
    
    for (int i=0; i<self.configure.bulletTrajectorys; i++) {
        if (self.bulletComments.count > 0){
            NSInteger index = arc4random()%trajectorys.count;
            int trajectory = [[trajectorys objectAtIndex:index] intValue]; //随机得到弹道
            
            [trajectorys removeObjectAtIndex:index];
            
            
            NSString *comment = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];  //??
            
            [self createBulletView:comment trajectory:trajectory];
        }
    }
}
- (void)createBulletView:(NSString *)comment trajectory:(int)trajectory{
    if (self.stopA){
        return;
    }
    BulletView *bullet = [[BulletView alloc]initWithComment:comment configure:self.configure];
    bullet.trajectory = trajectory;
    [self.bulletViews addObject:bullet];
    __weak typeof (bullet) weakBullet = bullet;
    __weak typeof (self) weakSelf = self;
    bullet.moveStatusBlock = ^(moveStatus status) {
        if (self.stopA){
            return;
        }
        switch (status) {
            case bulletStar:{
                //弹幕开始进入屏幕，将view 加入到弹幕管理的变量中
                [weakSelf.bulletViews addObject:weakBullet];
                break;
            }
            case bulletEnter:{
                //如果弹幕完全进入屏幕，判断是否还有剩余的弹幕，如果有则在j改弹幕轨道中添加一条
                NSString *comment = [weakSelf nextComment];
                if (comment){
                    [weakSelf createBulletView:comment trajectory:trajectory];
                }
                break;
            }
            case bulletEnd:{
                //移除屏幕后 需要销毁
                if ([weakSelf.bulletViews containsObject:weakBullet]){
                    [weakBullet stopA];
                    [weakSelf.bulletViews removeObject:weakBullet];
                    
                }
                if (weakSelf.bulletViews.count == 0){
                    weakSelf.stopA = YES;
                    [weakSelf start];
                }
                break;
            }
            default:
                break;
        }
        
    };
    
    if (self.generateViewBlock){
        self.generateViewBlock(bullet);
    }
    
    
}

- (NSString *)nextComment{
    if (self.bulletComments.count == 0){
        return nil;
    }
    NSString *comment = [self.bulletComments firstObject];
    if (comment){
        [self.bulletComments removeObjectAtIndex:0];
    }
    
    return comment;
}
- (NSMutableArray *)dataSource{
    if (!_dataSource){
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}
- (NSMutableArray *)bulletComments{
    if (!_bulletComments){
        _bulletComments = [[NSMutableArray alloc]init];
    }
    return _bulletComments;
}
- (NSMutableArray *)bulletViews{
    if (!_bulletViews){
        _bulletViews = [[NSMutableArray alloc]init];
    }
    return _bulletViews;
}
- (void)setBullDataSouce:(NSMutableArray *)BullDataSouce{
    self.dataSource = BullDataSouce;
}
@end

//
//  ViewController.m
//  commentDemo
//
//  Created by wemac on 2020/2/29.
//  Copyright © 2020 wemac. All rights reserved.
//

#import "ViewController.h"
#import "BulletManger.h"
#import "BulletView.h"
#import "BulletConfigure.h"

#define bheight 50
@interface ViewController ()
@property (nonatomic,strong)BulletManger *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BulletConfigure *configure = [BulletConfigure bulletConfigure];
    configure.titleColor = [UIColor whiteColor];
    configure.titleFont = [UIFont systemFontOfSize:15];
    configure.bgColors = [@[[UIColor orangeColor],[UIColor redColor],[UIColor greenColor]] mutableCopy];
    configure.bulletDuration = 4;
    configure.bulletHeight = bheight;
    configure.bulletCornerRadius = 25;
    configure.bulletTrajectorys = 5;
    
    self.manager = [[BulletManger alloc]initWithConfigure:configure];
    self.manager.BullDataSouce = [@[@"1~~~~",@"2~~~~~~~~~~~~~~~~~",@"4～～～",@"423多少",@"4的速度速度速度速度",@"4个复古风格",@"4买买买买买买",@"4而已 俄方地方地方。辅导费",@"4地方 8 8 8 8 8"] mutableCopy];
    __weak typeof (self) weakSelf = self;
    self.manager.generateViewBlock = ^(BulletView * _Nonnull view) {
        //将view 添加在controller中
        [weakSelf addView:view];
    };
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(startBu) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *stopbtn = [UIButton buttonWithType:UIButtonTypeCustom];
      stopbtn.backgroundColor = [UIColor redColor];
      stopbtn.frame = CGRectMake(100, 200, 100, 40);
      [self.view addSubview:stopbtn];
      
      [stopbtn addTarget:self action:@selector(stopBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}
- (void)startBu{
    [self.manager start];
}
- (void)stopBtn{
    [self.manager stop];
}
- (void)addView:(BulletView *)view{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    view.frame = CGRectMake(width, height/2 + view.trajectory* (bheight+10) , CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    
    [self.view addSubview:view];
    [view startA];
}
@end

//
//  HeaderView.m
//  TableViewSectionHeader
//
//  Created by yb on 16/7/28.
//  Copyright © 2016年 朱德强. All rights reserved.
//

#import "HeaderView.h"
#import "UIView+Extension.h"

@interface HeaderView ()
{
    UIButton * _lastBtn;
}
@property (nonatomic,weak) UILabel * line;

@end

@implementation HeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor greenColor];
        CGFloat width = [UIScreen mainScreen].bounds.size.width/3.0;
        for (NSInteger i = 0; i< 3; i ++) {
            UIButton * btn = [[UIButton alloc] init];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            btn.frame = CGRectMake(i * width, 0, width, 40);
            btn.tag = i + 100;
            [self addSubview:btn];
            switch (i) {
                case 0:
                {
                    btn.selected = YES;
                    [btn setTitle:@"篮球" forState:UIControlStateNormal];
                    UILabel * line = [[UILabel alloc] init];
                    line.backgroundColor = [UIColor redColor];
                    [self addSubview:line];
                    line.size = CGSizeMake(70, 1);
                    line.centerX = btn.centerX;
                    line.centerY = btn.height + 3;
                    self.line = line;
                    _lastBtn = btn;
                }
                    break;
                case 1:
                {
                    [btn setTitle:@"足球" forState:UIControlStateNormal];
                }
                    break;
                case 2:
                {
                    [btn setTitle:@"科比" forState:UIControlStateNormal];
                }
                    break;
                default:
                    break;
            }
        }
    }
    return self;
}
-(void)btnClick:(UIButton *)btn
{

    [self changeSelectedBtn:btn.tag-100];
    if (self.btnClick) {
        self.btnClick(btn.tag-100);
    }
}
-(void)changeSelectedBtn:(NSInteger)tag;
{
    UIButton * btn = (UIButton *)[self viewWithTag:tag + 100];
    _lastBtn.selected = NO;
    btn.selected = YES;
    self.line.centerX = btn.centerX;
    _lastBtn = btn;
}
@end

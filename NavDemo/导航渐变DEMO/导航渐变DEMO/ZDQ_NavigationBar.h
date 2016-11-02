//
//  ZDQ_NavigationBar.h
//  导航渐变DEMO
//
//  Created by yb on 16/1/18.
//  Copyright © 2016年 yb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDQ_NavigationBar : UINavigationBar

@property (nonatomic,strong)UIView *bgView;
/**
 *   显示导航条背景颜色
 */
- (void)show;
/**
 *   隐藏
 */
- (void)hidden;
@end

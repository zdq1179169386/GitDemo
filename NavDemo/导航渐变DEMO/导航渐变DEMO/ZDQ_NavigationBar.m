//
//  ZDQ_NavigationBar.m
//  导航渐变DEMO
//
//  Created by yb on 16/1/18.
//  Copyright © 2016年 yb. All rights reserved.
//

#import "ZDQ_NavigationBar.h"

@implementation ZDQ_NavigationBar

+(void)initialize
{
    [super initialize];
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    
    NSDictionary *titleAttr = @{
                                NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:15]
                                };
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttr];
    
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        for (UIView* view in  self.subviews) {
            if([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
                self.bgView=view;
        }
        
        
        
        
    }
    return self;
}
-(void)show
{
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.hidden = NO;
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    }];
}
-(void)hidden
{
    self.bgView.hidden=YES;
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    
}


@end

//
//  HeaderView.h
//  TableViewSectionHeader
//
//  Created by yb on 16/7/28.
//  Copyright © 2016年 朱德强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

@property (nonatomic,copy) void(^btnClick)(NSInteger tag);

-(void)changeSelectedBtn:(NSInteger)tag;

@end

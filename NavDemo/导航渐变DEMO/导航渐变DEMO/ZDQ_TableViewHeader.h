//
//  ZDQ_TableViewHeader.h
//  导航渐变DEMO
//
//  Created by yb on 16/1/19.
//  Copyright © 2016年 yb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDQ_TableViewHeader : UIView

@property (strong, nonatomic) IBOutlet UIImageView *bg;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;

/** <#label#> */
@property(nonatomic,strong) UIImageView * bgI;

/** <#label#> */
@property(nonatomic,strong) UIImageView * header;

- (void)scrollViewDidScroll:(UIScrollView*)scrollView;
- (void)resizeView;

@end

@interface ZDQ_TableViewHeaderManager : NSObject

@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UIView* bigImageView;
@property(nonatomic,strong)UIView* touXiangImageView;
-(void)creatTableHeaderManager:(UITableView *)tableView;


- (void)scrollViewDidScroll:(UIScrollView*)scrollView;
- (void)resizeView;

@end


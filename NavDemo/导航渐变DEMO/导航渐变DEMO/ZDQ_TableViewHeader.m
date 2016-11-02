//
//  ZDQ_TableViewHeader.m
//  导航渐变DEMO
//
//  Created by yb on 16/1/19.
//  Copyright © 2016年 yb. All rights reserved.
//  用 Masonry，不知道怎么实现

#import "ZDQ_TableViewHeader.h"
#import <Masonry.h>
@interface ZDQ_TableViewHeader ()

{
    CGRect headFrame;
    
    CGFloat _offset;
}






@end

@implementation ZDQ_TableViewHeader


-(void)awakeFromNib
{
    self.backgroundColor = [UIColor redColor];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView * bg = [UIImageView new];
        bg.image = [UIImage imageNamed:@"fj.jpg"];
        [self addSubview:bg];
        self.bgI = bg;
        
        UIImageView * header = [UIImageView new];
        header.image = [UIImage imageNamed:@"tx.jpeg"];
        header.layer.cornerRadius = 40;
        header.clipsToBounds = YES;
        [self addSubview:header];
        self.header = header;
        
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            
        }];
        
        [header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
//        self = [[NSBundle mainBundle] loadNibNamed:@"ZDQ_TableViewHeader" owner:nil options:nil].firstObject;

    }
    return self;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollView.contentOffset.y=%lf",scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y<0) {
//   
//        _offset = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
//        
//        [self setNeedsUpdateConstraints];
//        [self.bgI mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.size.width.equalTo(self).offset(offset);
//        
//        }];
        
        CGFloat offset = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        
        headFrame.size.width=[UIScreen mainScreen].bounds.size.width + offset;
        headFrame.size.height= self.frame.size.height + offset;
        self.bgI.frame= headFrame;
        
        [self viewDidLayoutSubviews:offset/2];
        
        
    }
    
    
}
-(void)updateConstraints
{
    NSLog(@"_offset=%lf",_offset);
//    [self.bgI mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self).insets(UIEdgeInsetsMake(-_offset, -_offset, _offset, _offset));
//        
//    }];
    [super updateConstraints];

}
- (void)viewDidLayoutSubviews:(CGFloat)offset
{
//    self.header.frame=CGRectMake(0, 0, 80+offset, 80+offset);
//     self.header.center=CGPointMake(_bigImageView.center.x, _bigImageView.center.y);
//    _touXiangImageView.layer.cornerRadius=_touXiangImageView.frame.size.width/2;
//    

}
//- (void)resizeView
//{
//    initFrame.size.width = _tableView.frame.size.width;
//    _bigImageView.frame = initFrame;
//    
//}


@end


@implementation ZDQ_TableViewHeaderManager
{
    CGRect  initFrame;
    CGFloat defaultViewHeight;
    CGRect   subViewsFrame;
}
-(void)creatTableHeaderManager:(UITableView *)tableView
{
    
    UIImageView * bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    bg.image = [UIImage imageNamed:@"fj.jpg"];
  
    UIImageView * header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    header.image = [UIImage imageNamed:@"tx.jpeg"];
    header.layer.cornerRadius = 40;
    header.clipsToBounds = YES;
    header.center = bg.center;
    
    _tableView=tableView;
    _bigImageView=bg;
    _touXiangImageView=header;
    initFrame=_bigImageView.frame;
    defaultViewHeight  = initFrame.size.height;
    subViewsFrame=_touXiangImageView.frame;
    
    _touXiangImageView.layer.cornerRadius=_touXiangImageView.frame.size.width/2;
    UIView* heardView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, initFrame.size.width, initFrame.size.height + 20)];
    heardView.backgroundColor = [UIColor redColor];
    [heardView addSubview:bg];
    [heardView addSubview:header];
    self.tableView.tableHeaderView=heardView;
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //     NSLog(@"scrollView.contentInset.top=%lf",scrollView.contentInset.top);
    //    CGRect f     = _bigImageView.frame;
    //    f.size.width = _tableView.frame.size.width;
    //    _bigImageView.frame  = f;
    
    if (scrollView.contentOffset.y<0) {
        CGFloat offset = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        
        initFrame.origin.x= - offset /2;
        initFrame.origin.y= - offset;
        initFrame.size.width=_tableView.frame.size.width+offset;
        initFrame.size.height=defaultViewHeight+offset;
        _bigImageView.frame=initFrame;
        
        [self viewDidLayoutSubviews:offset/2];
    }
    
    
}
- (void)viewDidLayoutSubviews:(CGFloat)offset
{
    
        _touXiangImageView.frame=CGRectMake(0, 0, 80+offset, 80+offset);
        _touXiangImageView.center=CGPointMake(_bigImageView.center.x, _bigImageView.center.y);
        _touXiangImageView.layer.cornerRadius=_touXiangImageView.frame.size.width/2;
    
    
}
//- (void)resizeView
//{
//    initFrame.size.width = _tableView.frame.size.width;
//    _bigImageView.frame = initFrame;
//    
//}


@end


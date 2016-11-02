
//
//  SectionView.m
//  蘑菇街Demo
//
//  Created by ZhuDeQiang on 16/7/29.
//  Copyright © 2016年 ZDQ. All rights reserved.
//

#import "SectionView.h"
#import "Test1Table.h"
#import "Test2TableView.h"
#import "Test3Table.h"
#import "HeaderView.h"

@interface SectionView ()<UIScrollViewDelegate>
{
    HeaderView * _head;
}

@property (nonatomic,weak) UIScrollView * scroll;

@end

@implementation SectionView

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        
        HeaderView * head = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        __weak typeof(self) weakSelf = self;
        head.btnClick = ^(NSInteger tag)
        {
            [weakSelf.scroll setContentOffset:CGPointMake(tag * [UIScreen mainScreen].bounds.size.width, 0) animated:YES];
        };
        [self.contentView addSubview:head];
        _head = head;
        
        UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.5;
        [self.contentView addSubview:line];
        
        UIScrollView * scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64-50)];
        scroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, [UIScreen mainScreen].bounds.size.height - 64-50);
        scroll.pagingEnabled = YES;
        scroll.delegate = self;
        [self.contentView addSubview:scroll];
        self.scroll = scroll;
        
        Test1Table * table1 = [[Test1Table alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64-50)];
//        table1.backgroundColor = [UIColor blueColor];
        [scroll addSubview:table1];
        
        Test2TableView * table2 = [[Test2TableView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64-50)];
//        table2.backgroundColor = [UIColor whiteColor];
        [scroll addSubview:table2];
        
        Test3Table * table3 = [[Test3Table alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*2, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64-50)];
//        table3.backgroundColor = [UIColor yellowColor];
        [scroll addSubview:table3];
        
        
    }
    return self;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;{
    NSInteger page = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    [_head changeSelectedBtn:page];
}
@end

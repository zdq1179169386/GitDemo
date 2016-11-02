
//
//  BaseTableView.m
//  蘑菇街Demo
//
//  Created by ZhuDeQiang on 16/7/29.
//  Copyright © 2016年 ZDQ. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    BOOL _canScroll;
}

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation BaseTableView

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:0];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
//        外部table 发来的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptNotihy:) name:@"TheInsideScroll" object:nil];
//        内嵌的table 离开顶部时的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptNotihy:) name:@"TheExternalScroll" object:nil];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return nil;
}
-(void)acceptNotihy:(NSNotification *)notify
{
    if ([notify.name isEqualToString:@"TheInsideScroll"]) {
//        外部table 发来的通知
        NSString * canScroll = notify.userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            _canScroll = YES;
            self.tableView.showsHorizontalScrollIndicator = YES;
        }
    }else if ([notify.name isEqualToString:@"TheExternalScroll"])
    {
//        内嵌table 发来的通知
        self.tableView.contentOffset = CGPointZero;
        _canScroll = NO;
        self.tableView.showsHorizontalScrollIndicator = NO;        
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!_canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<0) {
//        内嵌的table到顶了；通知外面的table滑动；
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TheExternalScroll" object:nil userInfo:@{@"canScroll":@"1"}];
    }
}


@end

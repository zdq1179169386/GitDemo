//
//  ViewController.m
//  PlayVoiceDemo
//
//  Created by qrh on 2018/8/15.
//  Copyright © 2018年 zdq. All rights reserved.
//

#import "ViewController.h"
#import "XZPlayVoiceCell.h"
#import "XZVoiceModel.h"
#import <AVFoundation/AVFoundation.h>
#import "XZEunmDefine.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * voiceArr;
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) id timeObserver;
@property (nonatomic, strong) NSIndexPath * currentIndexP;//点击那个index
@property (nonatomic, strong) NSIndexPath * lastIndexP;//上次点击的index
@property (nonatomic, strong) AVPlayerItem * playerItem;//当前播放的item
@property (nonatomic, strong) NSMutableDictionary * playerItemDict;//拖动播放的时候，需要playerItem ，所以将所有的 playerItem 缓存下来
@property (nonatomic, assign) BOOL  isDragging;//是否正在拖拽
@property (nonatomic, assign) BOOL  isScrolling;//是否正在滑动
@end

@implementation ViewController

-(void)dealloc
{
    [self destroyPlayer];
//    [self removeObserver:self forKeyPath:@"playerStatus"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//销毁playerItem
- (void)destroyPlayerItem {
    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        self.playerItem = nil;
        [self.player replaceCurrentItemWithPlayerItem:nil];
    }
}

//销毁player
- (void)destroyPlayer {
    
    [self destroyPlayerItem];
    [self.player removeObserver:self forKeyPath:@"rate"];
    [self.player removeTimeObserver:self.timeObserver];
    self.player = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * arr = @[@"http://other.web.ri01.sycdn.kuwo.cn/resource/n1/63/11/928642281.mp3",@"http://other.web.rf01.sycdn.kuwo.cn/resource/n3/55/26/3051054552.mp3",@"http://other.web.ri01.sycdn.kuwo.cn/resource/n2/35/24/2295039499.mp3",@"http://other.web.ra01.sycdn.kuwo.cn/resource/n3/128/17/55/3616442357.mp3",@"http://other.web.re01.sycdn.kuwo.cn/resource/n3/67/10/2645918637.mp3",@"http://other.web.rd01.sycdn.kuwo.cn/resource/n3/92/55/2088951929.mp3",@"http://other.web.ri01.sycdn.kuwo.cn/resource/n3/59/41/3810743077.mp3",@"http://other.web.ra01.sycdn.kuwo.cn/resource/n2/2011/05/16/962881557.mp3",@"http://other.web.ra01.sycdn.kuwo.cn/resource/n3/88/54/4286087274.mp3",@"http://other.web.ra01.sycdn.kuwo.cn/resource/n2/128/64/73/222129269.mp3",@"http://other.web.nf01.sycdn.kuwo.cn/resource/n1/68/17/981674338.mp3"];
    self.voiceArr = @[].mutableCopy;
    NSMutableArray * mArr = @[].mutableCopy;
    for (NSInteger i = 0; i < arr.count; i++) {
        XZVoiceModel * model = [XZVoiceModel new];
        model.contentURL = [NSURL URLWithString:arr[i]];
        model.playerStatus = VedioStatusPause;
        [mArr addObject:model];
    }
    [self.voiceArr addObjectsFromArray:mArr];

    [self.tableView reloadData];
    [self addPlayerListener];
}
- (void)addPlayerListener{
    if (self.player) {
        //播放器，播放速度监听
        [self.player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    //动态修改cell 的进度条和已播放时间lable
    __weak typeof(self) weakSelf = self;
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        __strong typeof(self) strSelf = weakSelf;
        float currentPlayTime = (double)weakSelf.playerItem.currentTime.value/weakSelf.playerItem.currentTime.timescale;
        if (weakSelf.playerItem.currentTime.value<0) {
            currentPlayTime = 0.01; //防止出现时间计算越界问题
        }
        //拖拽期间不更新数据
        XZVoiceModel * model = weakSelf.voiceArr[weakSelf.currentIndexP.row];
        XZPlayVoiceCell * cell = [weakSelf.tableView cellForRowAtIndexPath:weakSelf.currentIndexP];
        if (!weakSelf.isDragging && model.playerStatus != VedioStatusBuffering) {
            if (isnan(currentPlayTime)) {
                currentPlayTime = 0.01;
            }
            int time = round(currentPlayTime);
            cell.slider.value = time;
            cell.timeL.text = [weakSelf convertTime:time];
            model.progress = time / round(CMTimeGetSeconds(weakSelf.playerItem.duration));
        }
    }];
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //监听应用后台切换
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appEnteredBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    //播放中被打断
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterruption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    //拔掉耳机监听
}
//播放结束
- (void)playerFinished:(NSNotification *)notify{
    NSLog(@"播放完成");
    [self.playerItem seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        XZVoiceModel * model = self.voiceArr[self.currentIndexP.row];
        model.progress = 0;
        [self pause];
    }];
}
//进入后台
- (void)appEnteredBackground{
    NSLog(@"进入后台");
    [self pause];
}
//播放被打断
- (void)handleInterruption:(NSNotification *)notify{
    NSLog(@"播放被打断");
    [self pause];
}

//点击cell 播放 ,暂停按钮
- (void)playVoicde{
    if (self.lastIndexP) {
        //点击同一个
        XZVoiceModel * model = self.voiceArr[self.currentIndexP.row];
        if (self.lastIndexP == self.currentIndexP) {
            if (model.playerStatus == VedioStatusPause) {
                [self play];
            }else{
                [self pause];
            }
        }else{
            //点击不同个,如果上一个不是暂停状态先暂停上一个
            XZVoiceModel * lastModel = self.voiceArr[self.lastIndexP.row];
            if (lastModel.playerStatus != VedioStatusPause) {
                lastModel.playerStatus = VedioStatusPause;
                XZPlayVoiceCell * lastCell = [self.tableView cellForRowAtIndexPath:self.lastIndexP];
                [lastCell.playB setImage:[UIImage imageNamed:@"xz_play_voice"] forState:UIControlStateNormal];
                //设置缓存进度
                lastModel.progress = round(lastCell.slider.value) / round(lastModel.duration);
                [self.player pause];
            }
            //点击当前的
            AVPlayerItem * item = self.playerItemDict[@(self.currentIndexP.row)];
            if (!item) {
                //点击新的
                item = [[AVPlayerItem alloc] initWithURL:model.contentURL];
                self.playerItem = item;
                [self.playerItemDict setObject:self.playerItem forKey:@(self.currentIndexP.row)];
                [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
                model.playerStatus = VedioStatusBuffering;//缓冲中
            }else{
                self.playerItem = item;
                [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
                if (model.playerStatus == VedioStatusPause) {
                    if (model.progress > 0) {
                        [self.player pause];
                        CMTime time = CMTimeMake(round(model.progress * model.duration), 1);
                        [self.playerItem seekToTime:time completionHandler:^(BOOL finished) {
                            model.playerStatus = VedioStatusBuffering; //结束拖动后处于一个缓冲状态?如果直接拖到结束呢？
                            [self.player play];
                        }];
                    }else{
                        [self play];
                    }
                }else{
                    [self pause];
                }
            }
        }
    }else{
        XZVoiceModel * model = self.voiceArr[self.currentIndexP.row];
        AVPlayerItem * item = self.playerItemDict[@(self.currentIndexP.row)];
        if (!item) {
            //点击新的
            item = [[AVPlayerItem alloc] initWithURL:model.contentURL];
            self.playerItem = item;
            [self.playerItemDict setObject:item forKey:@(self.currentIndexP.row)];
            [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
            model.playerStatus = VedioStatusBuffering;//缓冲中
        }
    }
}
//切换播放时需要给不同的playeritem 添加观察者
- (void)addPlayerItemObserver{
    if (self.playerItem) {
        //监听播放状态
        [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        //监听缓冲进度
        [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
   
}
#pragma mark 监听捕获
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    int new = (int)[change objectForKey:@"new"];
    int old = (int)[change objectForKey:@"old"];
    if ([keyPath isEqualToString:@"status"]) {
        //playeritem 的播放状态监听
        if (new == old) {
            return;
        }
        AVPlayerItem * item = (AVPlayerItem *)object;
        if ([self.playerItem status] == AVPlayerStatusReadyToPlay) {
            CMTime  douration = item.duration;//音频总时长
            //设置当前的cell
            [self setMaxDuratuinForCell:CMTimeGetSeconds(douration)];
            NSLog(@"AVPlayerStatusReadyToPlay -- 音频时长%f",CMTimeGetSeconds(douration));
        }else if (self.playerItem.status == AVPlayerStatusFailed){
            [self playerFailed];
            NSLog(@"AVPlayerStatusFailed -- 播放异常");
        }else if (self.playerItem.status == AVPlayerStatusUnknown){
            [self pause];
            NSLog(@"AVPlayerStatusUnknown -- 未知原因停止");
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        //playeritem 的缓冲进度监听
        NSArray * array = ((AVPlayerItem *)object).loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        NSTimeInterval totalBuffer = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration);
        //设置cell 的缓存状态
        XZVoiceModel * model = self.voiceArr[self.currentIndexP.row];
        //当缓存到位后开启播放，取消loading
        if (totalBuffer > 0 && model.playerStatus == VedioStatusBuffering) {
            model.playerStatus = VedioStatusPause;
            [self play];
        }
        NSLog(@"---共缓冲---%.2f",totalBuffer);
    }else if ([keyPath isEqualToString:@"rate"]){
        //player 的播放速度监听
        if (new == old) {
            return;
        }
        XZVoiceModel * model = self.voiceArr[self.currentIndexP.row];
        AVPlayer * player = (AVPlayer *)object;
        if (player.rate == 0 && model.playerStatus != VedioStatusPause) {
            model.playerStatus = VedioStatusBuffering;
        }else if (player.rate == 1){
            model.playerStatus = VedioStatusPlaying;
        }
        NSLog(@"---播放速度---%f",player.rate);
    }else if ([keyPath isEqualToString:@"playerStatus"]){
        //监听每个模型的 playerStatus 属性的变化
        if (new == old) {
            return;
        }
        XZVoiceModel * model = self.voiceArr[self.currentIndexP.row];
        XZPlayVoiceCell * cell = [self.tableView cellForRowAtIndexPath:self.currentIndexP];
        switch (model.playerStatus) {
            case VedioStatusBuffering:
            {
                //cell 显示缓冲状态
            }
                break;
            case VedioStatusPause:
            {
                [cell.playB setImage:[UIImage imageNamed:@"xz_play_voice"] forState:UIControlStateNormal];
            }
                break;
            case VedioStatusPlaying:
            {
                [cell.playB setImage:[UIImage imageNamed:@"xz_playvoice_stop"] forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
    }

}
- (void)setMaxDuratuinForCell:(float)douration{
    XZPlayVoiceCell * cell = [self.tableView cellForRowAtIndexPath:self.currentIndexP];
    XZVoiceModel * model = self.voiceArr[self.currentIndexP.row];
    model.duration = round(douration);//刷新cell时候，给cell 赋值
    cell.slider.maximumValue = round(douration);
    //设置总时间
    cell.totalTimeL.text = [self convertTime:round(douration)];
    //初始化历史播放进度
    cell.slider.value = model.progress * douration;
    cell.timeL.text = [self convertTime:round(cell.slider.value)];
    
}
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}
//播放失败
- (void)playerFailed{
    
}
//给模型的 playstatus 添加监听
- (void)addModelPlayStatusObserver{
    XZVoiceModel * model = self.voiceArr[self.currentIndexP.row];
    [model addObserver:self forKeyPath:@"playerStatus" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}
//拖拽
- (void)dragAction{
    XZPlayVoiceCell * cell = [self.tableView cellForRowAtIndexPath:self.currentIndexP];
    cell.timeL.text = [self convertTime:round(cell.slider.value)];
}
//开始触摸进度条
- (void)sliderTouchDownAction{
    
}
//结束拖拽进度条
- (void)sliderTouchCancelAction{
    XZPlayVoiceCell * cell = [self.tableView cellForRowAtIndexPath:self.currentIndexP];
    CMTime time = CMTimeMake(cell.slider.value, 1);
    cell.timeL.text = [self convertTime:round(cell.slider.value)];
    XZVoiceModel * model = self.voiceArr[self.currentIndexP.row];
    if (model.playerStatus != VedioStatusPause) {
        [self.player pause];
        [self.playerItem seekToTime:time completionHandler:^(BOOL finished) {
            model.playerStatus = VedioStatusBuffering; //结束拖动后处于一个缓冲状态?如果直接拖到结束呢？
            [self.player play];
        }];
    }
}
//播放
- (void)play {
    XZVoiceModel * model = self.voiceArr[self.currentIndexP.row];
    if (self.player && model.playerStatus == VedioStatusPause ) {
        model.playerStatus = VedioStatusBuffering;
        [self.player play];
    }
}
//暂停
- (void)pause{
    XZVoiceModel * model = self.voiceArr[self.currentIndexP.row];
    if (self.player && model.playerStatus != VedioStatusPause ) {
        model.playerStatus = VedioStatusPause;
        [self.player pause];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.voiceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XZPlayVoiceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XZPlayVoiceCell"];
    if (!cell) {
        cell = [[XZPlayVoiceCell alloc]initWithStyle:0 reuseIdentifier:@"XZPlayVoiceCell"];
    }
    cell.model = self.voiceArr[indexPath.row];
    __weak typeof(self) weakSelf = self;
    cell.playVoicde = ^{
        if (self.currentIndexP) {
            self.lastIndexP = self.currentIndexP;
        }
        weakSelf.currentIndexP = indexPath;
        [weakSelf playVoicde];
        [weakSelf addPlayerItemObserver];
        [weakSelf addModelPlayStatusObserver];
        
    };
    cell.dragBlock = ^(float value) {
        [weakSelf dragAction];
    };
    cell.sliderTouchDownBlock = ^{
        weakSelf.isDragging = YES;
        [weakSelf sliderTouchDownAction];
    };
    cell.sliderTouchCancelBlock = ^(float value) {
        weakSelf.isDragging = NO;
        [weakSelf sliderTouchCancelAction];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    self.isScrolling = YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    self.isScrolling = YES;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;   
{
    self.isScrolling = NO;
}
- (AVPlayer *)player
{
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}
- (NSMutableDictionary *)playerItemDict
{
    if (!_playerItemDict) {
        _playerItemDict = @{}.mutableCopy;
    }
    return _playerItemDict;
}
@end

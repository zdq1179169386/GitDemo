//
//  XZPlayVoiceCell.m
//  XZStudyKit
//
//  Created by qrh on 2018/8/13.
//

#import "XZPlayVoiceCell.h"
#import <Masonry/Masonry.h>
#import "XZVoiceModel.h"
#import "XZEunmDefine.h"

@interface XZPlayVoiceCell ()

@end

@implementation XZPlayVoiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.playB];
    [self.contentView addSubview:self.slider];
    [self.contentView addSubview:self.totalTimeL];
    [self.contentView addSubview:self.timeL];
    [_playB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.centerY.equalTo(self.contentView);
    }];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playB.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.mas_equalTo(self.contentView).offset(-10);
    }];
    [_totalTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.mas_equalTo(self.slider.mas_bottom).offset(5);
    }];
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playB.mas_right).offset(10);
        make.centerY.mas_equalTo(self.totalTimeL.mas_centerY);
    }];
}

- (void)setModel:(XZVoiceModel *)model
{
    _model = model;
    if (model.playerStatus == VedioStatusPlaying) {
        //播放中
        [_playB setImage:[UIImage imageNamed:@"xz_playvoice_stop"] forState:UIControlStateNormal];
    }else{
        [_playB setImage:[UIImage imageNamed:@"xz_play_voice"] forState:UIControlStateNormal];
    }
    _totalTimeL.text = [self convertTime:model.duration];
    self.slider.maximumValue = round(model.duration);
    self.slider.value = model.progress > 0 ? model.progress * model.duration : 0;
    self.timeL.text = [self convertTime:round(self.slider.value)];
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

- (void)playVoice:(UIButton *)button{
    if (self.playVoicde) {
        self.playVoicde();
    }
}
- (void)valueChange:(UISlider *)slider{
//    BCLog(@"valueChange");
    if (self.dragBlock) {
        self.dragBlock(self.slider.value);
    }
}
- (void)sliderTouchDown:(UISlider *)slider{
//    BCLog(@"sliderTouchDown");
    if (self.sliderTouchDownBlock) {
        self.sliderTouchDownBlock();
    }
}
- (void)sliderTouchCancel:(UISlider *)slider{
//    BCLog(@"sliderTouchCancel");
    if (self.sliderTouchCancelBlock) {
        self.sliderTouchCancelBlock(self.slider.value);
    }
}
- (UIButton *)playB
{
    if (!_playB) {
        
        _playB = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_playB addTarget:self action:@selector(playVoice:) forControlEvents:UIControlEventTouchUpInside];
        [_playB setImage:[UIImage imageNamed:@"xz_play_voice"] forState:UIControlStateNormal];
    }
    return _playB;
}
- (UISlider *)slider
{
    if (!_slider) {
        _slider = [[UISlider alloc] init];
        _slider.value = 0.0;
//        _slider.maximumValue = 100;
        _slider.minimumValue = 0.0;
        _slider.continuous = YES;
        //设置滑块左边（小于部分）线条的颜色
        _slider.minimumTrackTintColor = [UIColor redColor];
        //设置滑块右边（大于部分）线条的颜色
        _slider.maximumTrackTintColor = [UIColor lightGrayColor];
        [_slider setThumbImage:[UIImage imageNamed:@"xz_playvoice_icon"] forState:UIControlStateNormal];
        [_slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_slider addTarget:self action:@selector(sliderTouchCancel:) forControlEvents:UIControlEventTouchUpInside];
    }
   return  _slider;
}
- (UILabel *)totalTimeL
{
    if (!_totalTimeL) {
        _totalTimeL = [UILabel new];
        _totalTimeL.font = [UIFont systemFontOfSize:13];
        _totalTimeL.textColor = [UIColor blackColor];
        _totalTimeL.text = @"00:00";
    }
    return _totalTimeL;
}
- (UILabel *)timeL
{
    if (!_timeL) {
        _timeL = [UILabel new];
        _timeL.font = [UIFont systemFontOfSize:13];
        _timeL.textColor = [UIColor blackColor];
        _timeL.text = @"00:00";
    }
    return _timeL;
}
@end

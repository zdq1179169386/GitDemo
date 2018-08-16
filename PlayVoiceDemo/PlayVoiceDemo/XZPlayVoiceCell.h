//
//  XZPlayVoiceCell.h
//  XZStudyKit
//
//  Created by qrh on 2018/8/13.
//

#import <UIKit/UIKit.h>
@class XZVoiceModel;
@interface XZPlayVoiceCell : UITableViewCell
@property (nonatomic, strong) UIButton * playB;
@property (nonatomic, strong) UISlider * slider;
@property (nonatomic, strong) UILabel * totalTimeL;
@property (nonatomic, strong) UILabel * timeL;

@property (nonatomic, copy) void (^ dragBlock) (float value);
@property (nonatomic, copy) void (^ sliderTouchDownBlock) (void);
@property (nonatomic, copy) void (^ sliderTouchCancelBlock) (float value);
@property (nonatomic, copy) void (^ playVoicde)(void);

@property (nonatomic, strong) XZVoiceModel * model;
@end

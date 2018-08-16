//
//  XZVoiceModel.h
//  PlayVoiceDemo
//
//  Created by qrh on 2018/8/15.
//  Copyright © 2018年 zdq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XZEunmDefine.h"
@interface XZVoiceModel : NSObject
@property (nonatomic, strong) NSURL * contentURL;
@property (nonatomic, assign) CGFloat  progress;//进度
@property (nonatomic, assign) CGFloat duration;//总时长
@property (nonatomic, assign) VedioStatus  playerStatus;//状态
@end

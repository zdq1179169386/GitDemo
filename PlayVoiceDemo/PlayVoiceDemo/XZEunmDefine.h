//
//  XZEunmDefine.h
//  PlayVoiceDemo
//
//  Created by qrh on 2018/8/15.
//  Copyright © 2018年 zdq. All rights reserved.
//

#ifndef XZEunmDefine_h
#define XZEunmDefine_h


typedef NS_ENUM(NSUInteger, VedioStatus) {
    VedioStatusPause,       // 暂停播放
    VedioStatusPlaying,       // 播放中
    VedioStatusBuffering,     // 缓冲中
    VedioStatusFinished,       //播放结束
    VedioStatusFailed        // 播放失败
};


#endif /* XZEunmDefine_h */

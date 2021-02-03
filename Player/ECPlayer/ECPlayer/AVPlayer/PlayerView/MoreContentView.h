//
//  SuperPlayerMoreView.h
//  TXLiteAVDemo
//
//  Created by annidyfeng on 2018/7/4.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECBasePlayerControlView.h"
#import "PlayerViewConfig.h"

#define MoreViewWidth 330

@class SuperPlayerControlView;

@interface MoreContentView : UIView

@property (weak) ECBasePlayerControlView *controlView;

@property UISlider *soundSlider;

@property UISlider *lightSlider;

@property (nonatomic) BOOL isLive;

@property PlayerViewConfig *playerConfig;
- (void)update;

@end

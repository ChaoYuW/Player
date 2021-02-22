//
//  PlayerView.h
//  ECPlayer
//
//  Created by chao on 2021/2/22.
//

#import <UIKit/UIKit.h>
#import "ECDefaultControlView.h"

NS_ASSUME_NONNULL_BEGIN

@class PlayerView;

@protocol PlayerDelegate <NSObject>
@optional
/// 返回事件
- (void)superPlayerBackAction:(PlayerView *)player;
/// 全屏改变通知
- (void)superPlayerFullScreenChanged:(PlayerView *)player;
/// 播放开始通知
- (void)superPlayerDidStart:(PlayerView *)player;
/// 播放结束通知
- (void)superPlayerDidEnd:(PlayerView *)player;
/// 播放错误通知
- (void)superPlayerError:(PlayerView *)player errCode:(int)code errMessage:(NSString *)why;
// 需要通知到父view的事件在此添加
@end

/// 播放器的状态
typedef NS_ENUM(NSInteger, PlayerState) {
    StateFailed,     // 播放失败
    StateBuffering,  // 缓冲中
    StatePlaying,    // 播放中
    StateStopped,    // 停止播放
    StatePause,      // 暂停播放
};

@interface PlayerView : UIView


/** 设置代理 */
@property (nonatomic, weak) id<PlayerDelegate> delegate;
/// 设置播放器的父view。播放过程中调用可实现播放窗口转移
@property (nonatomic, weak) UIView *fatherView;
/// 播放器的状态
@property (nonatomic, assign) PlayerState state;
/// 是否全屏
@property (nonatomic, assign, setter=setFullScreen:) BOOL isFullScreen;
/// 是否锁定旋转
@property (nonatomic, assign) BOOL isLockScreen;
/// 是否是直播流
@property (readonly) BOOL isLive;
/// 超级播放器控制层
@property (nonatomic) ECDefaultControlView *controlView;
/// 是否允许竖屏手势
@property (nonatomic) BOOL disableGesture;
/// 是否在手势中
@property (readonly)  BOOL isDragging;
/// 是否加载成功
@property (readonly)  BOOL  isLoaded;
/// 设置封面图片
@property (nonatomic) UIImageView *coverImageView;
/// 重播按钮
@property (nonatomic, strong) UIButton *repeatBtn;
/// 全屏退出
@property (nonatomic, strong) UIButton *repeatBackBtn;
/// 是否自动播放（在playWithModel前设置)
@property BOOL autoPlay;
/// 视频总时长
@property (nonatomic) CGFloat playDuration;
/// 视频当前播放时间
@property (nonatomic) CGFloat playCurrentTime;
/// 起始播放时间，用于从上次位置开播
@property CGFloat startTime;
/// 播放器配置
@property PlayerViewConfig *playerConfig;
/// 循环播放
@property (nonatomic) BOOL loop;

@end

NS_ASSUME_NONNULL_END

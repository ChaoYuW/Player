//
//  ECDefaultControlView.m
//  ECPlayer
//
//  Created by chao on 2021/2/3.
//

#import "ECDefaultControlView.h"
#import "PlayerHeader.h"
#import "UIView+Fade.h"
#import "UIView+Layout.h"
#import "StrUtils.h"
#import <Masonry.h>


#define BOTTOM_IMAGE_VIEW_HEIGHT 50

@interface ECDefaultControlView ()<PlayerSliderDelegate>



@end

@implementation ECDefaultControlView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addChildViews];
    }
    return self;
}
- (void)addChildViews
{
    [self addSubview:self.topImageView];
    [self addSubview:self.bottomImageView];
    [self.bottomImageView addSubview:self.startBtn];
    [self.bottomImageView addSubview:self.currentTimeLabel];
    [self.bottomImageView addSubview:self.videoSlider];
    [self.bottomImageView addSubview:self.resolutionBtn];
    [self.bottomImageView addSubview:self.fullScreenBtn];
    [self.bottomImageView addSubview:self.totalTimeLabel];
    
    [self.topImageView addSubview:self.captureBtn];
    [self.topImageView addSubview:self.danmakuBtn];
    [self.topImageView addSubview:self.moreBtn];
    [self addSubview:self.lockBtn];
    [self.topImageView addSubview:self.backBtn];
    
    [self addSubview:self.playeBtn];
    
    [self.topImageView addSubview:self.titleLabel];
    
    
    [self addSubview:self.backLiveBtn];
    
    // 添加子控件的约束
    [self makeSubViewsConstraints];
    
    self.captureBtn.hidden = YES;
    self.danmakuBtn.hidden = YES;
    self.moreBtn.hidden     = YES;
    self.resolutionBtn.hidden   = YES;
//    self.moreContentView.hidden = YES;
    // 初始化时重置controlView
    [self playerResetControlView];
}
- (void)makeSubViewsConstraints {
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.topImageView.mas_leading).offset(5);
        make.top.equalTo(self.topImageView.mas_top).offset(3);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(49);
        make.trailing.equalTo(self.topImageView.mas_trailing).offset(-10);
        make.centerY.equalTo(self.backBtn.mas_centerY);
    }];
    
    [self.captureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(49);
        make.trailing.equalTo(self.moreBtn.mas_leading).offset(-10);
        make.centerY.equalTo(self.backBtn.mas_centerY);
    }];
    
    [self.danmakuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(49);
        make.trailing.equalTo(self.captureBtn.mas_leading).offset(-10);
        make.centerY.equalTo(self.backBtn.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backBtn.mas_trailing).offset(5);
        make.centerY.equalTo(self.backBtn.mas_centerY);
        make.trailing.equalTo(self.captureBtn.mas_leading).offset(-10);
    }];
    
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.height.mas_equalTo(BOTTOM_IMAGE_VIEW_HEIGHT);
    }];
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomImageView.mas_leading).offset(5);
        make.top.equalTo(self.bottomImageView.mas_top).offset(10);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.startBtn.mas_trailing);
        make.centerY.equalTo(self.startBtn.mas_centerY);
        make.width.mas_equalTo(60);
    }];
    
    [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.trailing.equalTo(self.bottomImageView.mas_trailing).offset(-8);
        make.centerY.equalTo(self.startBtn.mas_centerY);
    }];
    
    [self.resolutionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_greaterThanOrEqualTo(45);
        make.trailing.equalTo(self.bottomImageView.mas_trailing).offset(-8);
        make.centerY.equalTo(self.startBtn.mas_centerY);
    }];
    
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.fullScreenBtn.mas_leading);
        make.centerY.equalTo(self.startBtn.mas_centerY);
        make.width.mas_equalTo(60);
    }];
    
    [self.videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.currentTimeLabel.mas_trailing);
        make.trailing.equalTo(self.totalTimeLabel.mas_leading);
        make.centerY.equalTo(self.currentTimeLabel.mas_centerY).offset(-1);
    }];
    
    [self.lockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(32);
    }];
    
    
    [self.playeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.center.equalTo(self);
    }];
    
    
    [self.backLiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.startBtn.mas_top).mas_offset(-15);
        make.width.mas_equalTo(70);
        make.centerX.equalTo(self);
    }];
}

/** 重置ControlView */
- (void)playerResetControlView {
    self.videoSlider.value           = 0;
    self.videoSlider.progressView.progress = 0;
    self.currentTimeLabel.text       = @"00:00";
    self.totalTimeLabel.text         = @"00:00";
    self.playeBtn.hidden             = YES;
    self.resolutionView.hidden       = YES;
    self.backgroundColor             = [UIColor clearColor];
    self.moreBtn.enabled         = YES;
    self.lockBtn.hidden              = !self.isFullScreen;
    
    self.danmakuBtn.enabled = YES;
    self.captureBtn.enabled = YES;
    self.moreBtn.enabled = YES;
    self.backLiveBtn.hidden              = YES;
}
#pragma mark - delegate
#pragma mark -PlayerSliderDelegate
- (void)onPlayerPointSelected:(PlayerPoint *)point {
    NSString *text = [NSString stringWithFormat:@"  %@ %@  ", [StrUtils timeFormat:point.timeOffset],
                      point.content];
    
    [self.pointJumpBtn setTitle:text forState:UIControlStateNormal];
    [self.pointJumpBtn sizeToFit];
    CGFloat x = self.videoSlider.ec_x + self.videoSlider.ec_w * point.where - self.pointJumpBtn.ec_h/2;
    if (x < 0)
        x = 0;
    if (x + self.pointJumpBtn.ec_h/2 > ScreenWidth)
        x = ScreenWidth - self.pointJumpBtn.ec_h/2;
    self.pointJumpBtn.tag = [self.videoSlider.pointArray indexOfObject:point];
    self.pointJumpBtn.ec_left(x).ec_bottom(60);
    self.pointJumpBtn.hidden = NO;
    
}

#pragma mark - Action

/**
 *  点击切换分别率按钮
 */
- (void)changeResolution:(UIButton *)sender {
    self.resoultionCurrentBtn.selected = NO;
    self.resoultionCurrentBtn.backgroundColor = [UIColor clearColor];
    self.resoultionCurrentBtn = sender;
    self.resoultionCurrentBtn.selected = YES;
    self.resoultionCurrentBtn.backgroundColor = RGBA(34, 30, 24, 1);
    
    // topImageView上的按钮的文字
    [self.resolutionBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    [self.delegate controlViewSwitch:self withDefinition:sender.titleLabel.text];
}
- (void)backBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(controlViewBack:)]) {
        [self.delegate controlViewBack:self];
    }
}

- (void)exitFullScreen:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(controlViewChangeScreen:withFullScreen:)]) {
        [self.delegate controlViewChangeScreen:self withFullScreen:NO];
    }
}

- (void)lockScrrenBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.isLockScreen = sender.selected;
    self.topImageView.hidden    = self.isLockScreen;
    self.bottomImageView.hidden = self.isLockScreen;
    if (self.isLive) {
        self.backLiveBtn.hidden = self.isLockScreen;
    }
    [self.delegate controlViewLockScreen:self withLock:self.isLockScreen];
    [self fadeOut:3];
}
- (void)playBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.delegate controlViewPlay:self];
    } else {
        [self.delegate controlViewPause:self];
    }
    [self cancelFadeOut];
}
- (void)fullScreenBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.fullScreen = !self.fullScreen;
    [self.delegate controlViewChangeScreen:self withFullScreen:YES];
    [self fadeOut:3];
}
- (void)captureBtnClick:(UIButton *)sender {
    [self.delegate controlViewSnapshot:self];
    [self fadeOut:3];
}
- (void)danmakuBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self fadeOut:3];
}
- (void)moreBtnClick:(UIButton *)sender {
    self.topImageView.hidden = YES;
    self.bottomImageView.hidden = YES;
    self.lockBtn.hidden = YES;
    
//    self.moreContentView.playerConfig = self.playerConfig;
//    [self.moreContentView update];
//    self.moreContentView.hidden = NO;
    
    [self cancelFadeOut];
    self.isShowSecondView = YES;
}
- (void)progressSliderTouchBegan:(UISlider *)sender {
    self.isDragging = YES;
    [self cancelFadeOut];
}
- (void)progressSliderValueChanged:(UISlider *)sender {
    [self.delegate controlViewPreview:self where:sender.value];
}
- (void)progressSliderTouchEnded:(UISlider *)sender {
    [self.delegate controlViewSeek:self where:sender.value];
    self.isDragging = NO;
    [self fadeOut:5];
}

- (void)backLiveClick:(UIButton *)sender {
    [self.delegate controlViewReload:self];
}
- (void)pointJumpClick:(UIButton *)sender {
    self.pointJumpBtn.hidden = YES;
    PlayerPoint *point = [self.videoSlider.pointArray objectAtIndex:self.pointJumpBtn.tag];
    [self.delegate controlViewSeek:self where:point.where];
    [self fadeOut:0.1];
}
/**
 *  屏幕方向发生变化会调用这里
 */
- (void)setOrientationLandscapeConstraint {
    self.fullScreen             = YES;
    self.lockBtn.hidden         = NO;
    self.fullScreenBtn.selected = self.isLockScreen;
    self.fullScreenBtn.hidden   = YES;
    self.resolutionBtn.hidden   = NO;
    self.moreBtn.hidden         = NO;
    self.captureBtn.hidden      = NO;
    self.danmakuBtn.hidden      = NO;
    
    [self.backBtn setImage:PlayerImage(@"back_full") forState:UIControlStateNormal];

    
    [self.totalTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (self.resolutionArray.count > 0) {
            make.trailing.equalTo(self.resolutionBtn.mas_leading);
        } else {
            make.trailing.equalTo(self.bottomImageView.mas_trailing);
        }
        make.centerY.equalTo(self.startBtn.mas_centerY);
        make.width.mas_equalTo(self.isLive?10:60);
    }];
    
    [self.bottomImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat b = self.superview.ec_safeAreaBottomGap;
        make.height.mas_equalTo(BOTTOM_IMAGE_VIEW_HEIGHT+b);
//        make.height.mas_equalTo(BOTTOM_IMAGE_VIEW_HEIGHT);
    }];
    
    self.videoSlider.hiddenPoints = NO;
}
/**
 *  设置竖屏的约束
 */
- (void)setOrientationPortraitConstraint {
    self.fullScreen             = NO;
    self.lockBtn.hidden         = YES;
    self.fullScreenBtn.selected = NO;
    self.fullScreenBtn.hidden   = NO;
    self.resolutionBtn.hidden   = YES;
    self.moreBtn.hidden         = YES;
    self.captureBtn.hidden      = YES;
    self.danmakuBtn.hidden      = YES;
//    self.moreContentView.hidden = YES;
    self.resolutionView.hidden  = YES;
    
    [self.totalTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.fullScreenBtn.mas_leading);
        make.centerY.equalTo(self.startBtn.mas_centerY);
        make.width.mas_equalTo(self.isLive?10:60);
    }];
    
    [self.bottomImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(BOTTOM_IMAGE_VIEW_HEIGHT);
    }];
    
    self.videoSlider.hiddenPoints = YES;
    self.pointJumpBtn.hidden = YES;
}

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView                        = [[UIImageView alloc] init];
        _topImageView.userInteractionEnabled = YES;
        _topImageView.image                  = PlayerImage(@"top_shadow");
    }
    return _topImageView;
}
- (UIImageView *)bottomImageView {
    if (!_bottomImageView) {
        _bottomImageView                        = [[UIImageView alloc] init];
        _bottomImageView.userInteractionEnabled = YES;
        _bottomImageView.image                  = PlayerImage(@"bottom_shadow");
    }
    return _bottomImageView;
}
- (UIButton *)lockBtn {
    if (!_lockBtn) {
        _lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lockBtn.exclusiveTouch = YES;
        [_lockBtn setImage:PlayerImage(@"unlock-nor") forState:UIControlStateNormal];
        [_lockBtn setImage:PlayerImage(@"lock-nor") forState:UIControlStateSelected];
        [_lockBtn addTarget:self action:@selector(lockScrrenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lockBtn;
}
- (UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setImage:PlayerImage(@"play") forState:UIControlStateNormal];
        [_startBtn setImage:PlayerImage(@"pause") forState:UIControlStateSelected];
        [_startBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
- (UILabel *)currentTimeLabel {
    if (!_currentTimeLabel) {
        _currentTimeLabel               = UILabel.new;
        _currentTimeLabel.textColor     = UIColor.whiteColor;
        _currentTimeLabel.font          = [UIFont systemFontOfSize:12.0f];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}
- (PlayerSlider *)videoSlider {
    if (!_videoSlider) {
        _videoSlider                       = [[PlayerSlider alloc] init];
        [_videoSlider setThumbImage:PlayerImage(@"slider_thumb") forState:UIControlStateNormal];
        _videoSlider.minimumTrackTintColor = TintColor;
        // slider开始滑动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        // slider滑动中事件
        [_videoSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        // slider结束滑动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        _videoSlider.delegate = self;
    }
    return _videoSlider;
}
- (UILabel *)totalTimeLabel {
    if (!_totalTimeLabel) {
        _totalTimeLabel               = UILabel.new;
        _totalTimeLabel.textColor     = UIColor.whiteColor;
        _totalTimeLabel.font          = [UIFont systemFontOfSize:12.0f];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}

- (UIButton *)fullScreenBtn {
    if (!_fullScreenBtn) {
        _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenBtn setImage:PlayerImage(@"fullscreen") forState:UIControlStateNormal];
        [_fullScreenBtn addTarget:self action:@selector(fullScreenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenBtn;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

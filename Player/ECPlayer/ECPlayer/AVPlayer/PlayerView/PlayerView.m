//
//  PlayerView.m
//  ECPlayer
//
//  Created by chao on 2021/2/22.
//

#import "PlayerView.h"
#import "UIView+Fade.h"

@interface PlayerView () <UIGestureRecognizerDelegate>

/** 进入后台*/
@property (nonatomic, assign) BOOL                   didEnterBackground;
/** 单击 */
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
/** 双击 */
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;
/** 播放完了*/
@property (nonatomic, assign) BOOL                   playDidEnd;
/** 是否被用户暂停 */
@property (nonatomic, assign) BOOL                   isPauseByUser;
@end

@implementation PlayerView

#pragma mark - life Cycle

/**
 *  代码初始化调用此方法
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) { [self initializeThePlayer]; }
    return self;
}
/**
 *  storyboard、xib加载playerView会调用此方法
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeThePlayer];
}
/**
 *  初始化player
 */
- (void)initializeThePlayer {
    
    _playerConfig = PlayerViewConfig.new;
    //添加通知
    [self addNotifications];
    //添加手势
    [self createGesture];
    self.autoPlay = YES;
}
#pragma mark - 观察者、通知
/**
 *  添加观察者、通知
 */
- (void)addNotifications {
    // app退到后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationWillResignActiveNotification object:nil];
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayground:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    // 监测设备方向
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onStatusBarOrientationChange)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}
/**
 *  创建手势
 */
- (void)createGesture {
    // 单击
    self.singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction:)];
    self.singleTap.delegate                = self;
    self.singleTap.numberOfTouchesRequired = 1; //手指数
    self.singleTap.numberOfTapsRequired    = 1;
    [self addGestureRecognizer:self.singleTap];
    
    // 双击(播放/暂停)
    self.doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapAction:)];
    self.doubleTap.delegate                = self;
    self.doubleTap.numberOfTouchesRequired = 1; //手指数
    self.doubleTap.numberOfTapsRequired    = 2;
    [self addGestureRecognizer:self.doubleTap];

    // 解决点击当前view时候响应其他控件事件
    [self.singleTap setDelaysTouchesBegan:YES];
    [self.doubleTap setDelaysTouchesBegan:YES];
    // 双击失败响应单击事件
    [self.singleTap requireGestureRecognizerToFail:self.doubleTap];
    
    // 加载完成后，再添加平移手势
    // 添加平移手势，用来控制音量、亮度、快进快退
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDirection:)];
    panRecognizer.delegate = self;
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelaysTouchesBegan:YES];
    [panRecognizer setDelaysTouchesEnded:YES];
    [panRecognizer setCancelsTouchesInView:YES];
    [self addGestureRecognizer:panRecognizer];
}
#pragma mark - Action

/**
 *   轻拍方法
 *
 *  @param gesture UITapGestureRecognizer
 */
- (void)singleTapAction:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        if (self.playDidEnd) {
            return;
        }
        
        if (self.controlView.hidden) {
            [[self.controlView fadeShow] fadeOut:5];
        }else{
            [self.controlView fadeOut:0.2];
        }
    }
}
/**
 *  双击播放/暂停
 *
 *  @param gesture UITapGestureRecognizer
 */
- (void)doubleTapAction:(UIGestureRecognizer *)gesture {
    if (self.playDidEnd) { return;  }
    // 显示控制层
    [self.controlView fadeShow];
    if (self.isPauseByUser) {
        [self resume];//播放
    }else {
        [self pause];
    }
    
}
#pragma mark - UIPanGestureRecognizer手势方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return YES;
    }
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        if (!self.isLoaded) { return NO; }
        if (self.isLockScreen) { return NO; }
        
        if (self.disableGesture) {
            if (!self.isFullScreen) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}
/**
 *  pan手势事件
 *
 *  @param pan UIPanGestureRecognizer
 */
- (void)panDirection:(UIPanGestureRecognizer *)pan {
    //根据在view上Pan的位置，确定是调音量还是亮度
    CGPoint locationPoint = [pan locationInView:self];
    // 我们要响应水平移动和垂直移动
    // 根据上次和本次移动的位置，算出一个速率的point
    CGPoint veloctyPoint = [pan velocityInView:self];
    if (self.state == StateStopped)
        return;
    
    //判断是垂直移动还是水平移动
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{ //开始移动
            //使用绝对值来判断移动方向
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            if (x > y) {// 水平移动
                //取消隐藏
//                self.
            }else if (x < y){//垂直移动
                
            }
//            self.isDragging = YES;
            
        }
            break;
        case UIGestureRecognizerStateChanged:{ //正在移动
            
            
            break;
        }
        case UIGestureRecognizerStateEnded:{ //移动停止
            
            break;
        }
        case UIGestureRecognizerStateCancelled:{
            
            break;
        }
            
        default:
            break;
    }
}
#pragma mark - UIKit Notifications

/**
 *  应用退到后台
 */
- (void)appDidEnterBackground:(NSNotification *)notify {
    self.didEnterBackground = YES;
    if (self.isLive) {
        return;
    }
    
}
/**
 *  应用进入前台
 */
- (void)appDidEnterPlayground:(NSNotification *)notify {
    NSLog(@"appDidEnterPlayground");
    self.didEnterBackground = NO;
    if (self.isLive) {
        return;
    }
}
/**
 *  屏幕方向发生变化会调用这里
 */
- (void)onDeviceOrientationChange {
    if (!self.isLoaded) { return; }
    if (self.isLockScreen) { return; }
    if (self.didEnterBackground) { return; };
    
}
// 状态条变化通知（在前台播放才去处理）
- (void)onStatusBarOrientationChange{
    
}
/**
 *  播放
 */
- (void)resume {
}
/**
 * 暂停
 */
- (void)pause {
}




- (void)dealloc {
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

@end

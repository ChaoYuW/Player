//
//  ECAVPlayerViewController.m
//  ECPlayer
//
//  Created by chao on 2021/2/2.
//

#import "ECAVPlayerViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ECDefaultControlView.h"

@interface ECAVPlayerViewController ()<PlayerControlViewDelegate>


@property (strong, nonatomic) AVPlayer *player;
//@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;

@property(nonatomic,strong)UIView *backView; // 上面一层View
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIProgressView *progress; // 缓冲条
@property (nonatomic,strong) ECDefaultControlView *controlView;


@end

@implementation ECAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _width = [[UIScreen mainScreen]bounds].size.width;
    _height = [[UIScreen mainScreen]bounds].size.height;
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"https://hard.storage.shmedia.tech/6319837d438b4bc099bbd5205d3f179e.mp4"]];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = CGRectMake(0, 0, _width, _height);
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:playerLayer];
    self.controlView = [[ECDefaultControlView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    self.controlView.delegate = self;
    [self.view addSubview:self.controlView];
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        AVPlayerItem *playerItem = self.player.currentItem;
        CGFloat currentTime = CMTimeGetSeconds(time);
        CGFloat totalTime = CMTimeGetSeconds(playerItem.duration);
        CGFloat value = currentTime/totalTime;
        [self.controlView setProgressTime:currentTime totalTime:totalTime progressValue:value playableValue:0];
    }];
    
    
    
//    [self.view addSubview:self.backView];
//    [self.view addSubview:self.topView];
//    [self.backView addSubview:self.progress];
    
//    [self layoutFrame];
    
    
    //AVPlayer播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    
}

- (void)layoutFrame
{
    self.backView.frame = CGRectMake(0, 0, _width, _height);
    self.topView.frame = CGRectMake(0, 0, _width, _height*0.15);
}
/** 播放 */
- (void)controlViewPlay:(UIView *)controlView
{
    [self.player play];
}
/** 暂停 */
- (void)controlViewPause:(UIView *)controlView
{
    [_player pause];
}
- (void)controlViewDidChangeScreen:(UIView *)controlView
{
    
}
- (void)moviePlayDidEnd:(id)sender
{
    AVPlayerItem *playerItem = self.player.currentItem;
    [playerItem seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        
    }];
}
#pragma mark -
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
//        NSLog(@"Time Interval:%f",timeInterval);
//        CMTime duration = self.playerItem.duration;
//        CGFloat totalDuration = CMTimeGetSeconds(duration);
//        [self.progress setProgress:timeInterval / totalDuration animated:NO];
        AVPlayerItem *playerItem = self.player.currentItem;
        
        CMTime duration = playerItem.duration;
        //总时长
        CGFloat totalTime = CMTimeGetSeconds(duration);
        CGFloat currentTime = CMTimeGetSeconds(playerItem.currentTime);
        CGFloat value = currentTime/totalTime;

        
    }else if ([keyPath isEqualToString:@"status"])
    {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue]; // 获取更改后的状态
        if (status == AVPlayerStatusReadyToPlay) {
            AVPlayerItem *item = (AVPlayerItem *)object;
            CMTime duration = item.duration; // 获取视频长度
            
        }else if (status == AVPlayerStatusFailed)
        {
            NSLog(@"AVPlayerStatusFailed");
        }else
        {
            NSLog(@"AVPlayerStatusUnknown");
        }
    }
}
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
}
- (UIView *)backView
{
    if (_backView == nil) {
        _backView = UIView.new;
        _backView.backgroundColor = UIColor.clearColor;
    }
    return _backView;
}
- (UIView *)topView
{
    if (_topView == nil) {
        _topView = UIView.new;
        _topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _topView;
}
- (UIProgressView *)progress
{
    if (_progress == nil) {
        _progress = UIProgressView.new;
    }
    return _progress;
}
@end

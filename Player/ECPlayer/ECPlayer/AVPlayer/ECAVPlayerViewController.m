//
//  ECAVPlayerViewController.m
//  ECPlayer
//
//  Created by chao on 2021/2/2.
//

#import "ECAVPlayerViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ECAVPlayerViewController ()


@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;

@property(nonatomic,strong)UIView *backView; // 上面一层View
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIProgressView *progress; // 缓冲条
//@property ()

@end

@implementation ECAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _width = [[UIScreen mainScreen]bounds].size.height;
    _height = [[UIScreen mainScreen]bounds].size.width;
    
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"https://hard.storage.shmedia.tech/6319837d438b4bc099bbd5205d3f179e.mp4"]];
    
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = CGRectMake(0, 0, _width, _height);
    playerLayer.videoGravity = AVLayerVideoGravityResize;
    [self.view.layer addSublayer:playerLayer];
    
    [self.player play];
    
    [self.view addSubview:self.backView];
    [self.view addSubview:self.topView];
    [self.backView addSubview:self.progress];
    
    [self layoutFrame];
    
    
    //AVPlayer播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    
}

- (void)layoutFrame
{
    self.backView.frame = CGRectMake(0, 0, _width, _height);
    self.topView.frame = CGRectMake(0, 0, _width, _height*0.15);
}

- (void)moviePlayDidEnd:(id)sender
{
    [_player pause];
}
#pragma mark -
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
//        NSLog(@"Time Interval:%f",timeInterval);
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.progress setProgress:timeInterval / totalDuration animated:NO];
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

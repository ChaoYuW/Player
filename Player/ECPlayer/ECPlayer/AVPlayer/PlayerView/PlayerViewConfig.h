//
//  PlayerViewConfig.h
//  ECPlayer
//
//  Created by chao on 2021/2/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerViewConfig : NSObject

/// 是否镜像，默认NO
@property BOOL mirror;
/// 是否硬件加速，默认YES
@property BOOL hwAcceleration;
/// 播放速度，默认1.0
@property CGFloat playRate;
/// 是否静音，默认NO
@property BOOL mute;
/// 填充模式，默认铺满。 参见 TXLiveSDKTypeDef.h
@property NSInteger renderMode;
/// http头，跟进情况自行设置
@property NSDictionary *headers;
/// 播放器最大缓存个数
@property (nonatomic) NSInteger maxCacheItem;
/// 时移域名，默认为playtimeshift.live.myqcloud.com
@property NSString *playShiftDomain;
/// log打印
@property BOOL enableLog;
@end

NS_ASSUME_NONNULL_END

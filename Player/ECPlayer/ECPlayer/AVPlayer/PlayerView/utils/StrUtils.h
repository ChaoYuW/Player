//
//  StrUtils.h
//  ECPlayer
//
//  Created by chao on 2021/2/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *kStrLoadFaildRetry;
extern NSString *kStrBadNetRetry;
extern NSString *kStrTimeShiftFailed;
extern NSString *kStrHDSwitchFailed;
extern NSString *kStrWeakNet;

@interface StrUtils : NSObject

+ (NSString *)timeFormat:(NSInteger)totalTime;
@end

NS_ASSUME_NONNULL_END

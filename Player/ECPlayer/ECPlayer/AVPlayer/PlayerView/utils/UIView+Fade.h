//
//  UIView+Fade.h
//  ECPlayer
//
//  Created by chao on 2021/2/3.
//

#import <UIKit/UIKit.h>

@interface UIView (Fade)

- (UIView *)fadeShow;
- (void)fadeOut:(NSTimeInterval)delay;
- (void)cancelFadeOut;
@end

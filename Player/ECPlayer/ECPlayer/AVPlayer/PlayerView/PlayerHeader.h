//
//  PlayerHeader.h
//  ECPlayer
//
//  Created by chao on 2021/2/3.
//

#ifndef PlayerHeader_h
#define PlayerHeader_h

// 颜色值RGB
#define RGBA(r,g,b,a)                       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 屏幕的宽
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
// 屏幕的高
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
// 图片路径
#define PlayerImage(file)              [UIImage imageNamed:[@"SuperPlayer.bundle" stringByAppendingPathComponent:file]]

#define TintColor RGBA(252, 89, 81, 1)
#endif /* PlayerHeader_h */

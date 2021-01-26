//
//  ECHaftView.h
//  ECPlayer
//
//  Created by chao on 2021/1/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^BlockMove)(CGPoint point);
typedef void(^BlockMoveEnd)(void);
@interface ECHaftView : UIView

@property (nonatomic,copy)BlockMove blockMove;
@property (nonatomic,copy)BlockMoveEnd blockMoveEnd;
/**
 增加左边的相应区域
 */
@property (nonatomic,assign)NSInteger lefEdgeInset;
/**
 增加右边的相应区域
 */
@property (nonatomic,assign)NSInteger rightEdgeInset;
/**
 增加上边的相应区域
 */
@property (nonatomic,assign)NSInteger topEdgeInset;
/**
 增加下边的相应区域
 */
@property (nonatomic,assign)NSInteger bottomEdgeInset;
@end

NS_ASSUME_NONNULL_END

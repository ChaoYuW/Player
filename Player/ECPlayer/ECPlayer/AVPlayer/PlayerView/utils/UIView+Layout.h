

#define ec_weakify(object) autoreleasepool   {} __weak  typeof(object) weak##object = object;
#define ec_strongify(object) autoreleasepool {} __strong  typeof(weak##object) object = weak##object;

#import <UIKit/UIKit.h>

@interface UIView (Layout)

@property (nonatomic) CGFloat ec_x;            ///<< frame.x
@property (nonatomic) CGFloat ec_y;            ///<< frame.y
@property (nonatomic) CGFloat ec_w;            ///<< frame.size.width
@property (nonatomic) CGFloat ec_h;            ///<< frame.size.height
@property (nonatomic) CGSize ec_s;             ///<< frame.size
@property (nonatomic) CGFloat ec_r;            ///<< right
@property (nonatomic) CGFloat ec_b;            ///<< bottom


@property (nonatomic) CGFloat ec_centerX;      ///<< self.center.x
@property (nonatomic) CGFloat ec_centerY;      ///<< self.center.y

@property (readonly) CGFloat ec_maxY;         ///<< get CGRectGetMaxY
@property (readonly) CGFloat ec_minY;         ///<< get CGRectGetMinY
@property (readonly) CGFloat ec_maxX;         ///<< get CGRectGetMaxX
@property (readonly) CGFloat ec_minX;         ///<< get CGRectGetMinX

@property (readonly) UIView *ec_sibling;      //兄弟视图
@property (readonly) UIViewController *ec_viewController;  //self Responder UIViewControler

// iPhoneX adapt

@property (readonly) CGFloat ec_safeAreaBottomGap;
@property (readonly) CGFloat ec_safeAreaTopGap;
@property (readonly) CGFloat ec_safeAreaLeftGap;
@property (readonly) CGFloat ec_safeAreaRightGap;

/*
   示例链接编程
   self.ec_width(100).ec_height(100).ec_left(10).ec_top(10)
*/
- (UIView * (^)(CGFloat top))ec_top;            ///< set frame y
- (UIView * (^)(CGFloat bottom))ec_bottom;      ///< set frame y
- (UIView * (^)(CGFloat right))ec_flexToBottom; ///< set frame height
- (UIView * (^)(CGFloat left))ec_left;          ///< set frame x
- (UIView * (^)(CGFloat right))ec_right;        ///< set frame x
- (UIView * (^)(CGFloat right))ec_flexToRight;  ///< set frame width
- (UIView * (^)(CGFloat width))ec_width;        ///< set frame width
- (UIView * (^)(CGFloat height))ec_height;      ///< set frame height
- (UIView * (^)(CGFloat x))ec__centerX;         ///< set center
- (UIView * (^)(CGFloat y))ec__centerY;         ///< set center
- (UIView * (^)(CGSize size))ec_size;          ///< set size
/*
 相对父View
 */
- (UIView * (^)(void))ec_center;                 ///< 居中
- (UIView * (^)(void))ec_fill;                   ///< 填充

/*
 相对与兄弟节点，线性布局
 */
- (UIView * (^)(CGFloat space))ec_hstack;        ///< 水平，居中对齐
- (UIView * (^)(CGFloat space))ec_vstack;        ///< 垂直，居中对齐


- (UIView * (^)(void))ec_sizeToFit;              ///< sizeToFit

@end





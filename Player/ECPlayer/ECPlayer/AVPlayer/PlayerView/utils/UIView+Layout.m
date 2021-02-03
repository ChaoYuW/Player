#import "UIView+Layout.h"
#import <objc/runtime.h>

@implementation UIView (Layout)

#pragma mark - frame
- (void)setEc_x:(CGFloat)ec_x {
    CGRect frame = self.frame;
    frame.origin.x = ec_x;
    self.frame = frame;
}

- (CGFloat)ec_x {
    return self.frame.origin.x;
}

- (void)setEc_y:(CGFloat)ec_y {
    CGRect frame = self.frame;
    frame.origin.y = ec_y;
    self.frame = frame;
}
- (CGFloat)ec_y {
    return self.frame.origin.y;
}
- (void)setEc_w:(CGFloat)ec_w {
    CGRect frame = self.frame;
    frame.size.width = ec_w;
    self.frame = frame;
}

- (CGFloat)ec_w {
    return self.frame.size.width;
}

- (void)setEc_h:(CGFloat)ec_h {
    CGRect frame = self.frame;
    frame.size.height = ec_h;
    self.frame = frame;
}

- (CGFloat)ec_h {
    return self.frame.size.height;
}

- (void)setEc_s:(CGSize)ec_s {
    CGRect frame = self.frame;
    frame.size = ec_s;
    self.frame = frame;
}

- (CGSize)ec_s {
    return self.frame.size;
}

-(CGFloat)ec_centerX {
    return self.center.x;
}

-(CGFloat)ec_centerY {
    return self.center.y;
}

-(void)setEc_centerX:(CGFloat)ec_centerX {
    CGPoint center = self.center;
    center.x = ec_centerX;
    self.center = center;
}

-(void)setEc_centerY:(CGFloat)ec_centerY {
    CGPoint center = self.center;
    center.y = ec_centerY;
    self.center = center;
}

- (CGFloat)ec_r {
    NSCAssert(self.superview, @"must add subview first");
    return self.superview.ec_w - self.ec_maxX;
}

- (void)setEc_r:(CGFloat)ec_r {
    self.ec_x += self.ec_r - ec_r;
}

- (CGFloat)ec_b {
    NSCAssert(self.superview, @"must add subview first");
    return self.superview.ec_h - self.ec_maxY;
}

- (void)setEc_b:(CGFloat)ec_b {
    self.ec_y += self.ec_b - ec_b;
}

- (CGFloat)ec_maxY {
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)ec_minY {
    return CGRectGetMinY(self.frame);
}
- (CGFloat)ec_maxX {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)ec_minX {
    return CGRectGetMinX(self.frame);
}

#pragma mark - chain call

-(UIView *(^)(CGFloat))ec_top {
    @ec_weakify(self);
    return ^(CGFloat m_top){
        @ec_strongify(self);
        self.ec_y = m_top;
        return self;
    };
}

-(UIView *(^)(CGFloat))ec_bottom {
    @ec_weakify(self);
    return ^(CGFloat m_bottom){
        @ec_strongify(self);
        self.ec_b = m_bottom;
        return self;
    };
}
-(UIView *(^)(CGFloat))ec_flexToBottom {
    @ec_weakify(self);
    return ^(CGFloat m_flexToBottom){
        @ec_strongify(self);
        self.ec_h += self.ec_b - m_flexToBottom;
        return self;
    };
}
-(UIView *(^)(CGFloat))ec_left {
    @ec_weakify(self);
    return ^(CGFloat m_left){
        @ec_strongify(self);
        self.ec_x = m_left;
        return self;
    };
}

-(UIView *(^)(CGFloat))ec_right {
    @ec_weakify(self);
    return ^(CGFloat m_right){
        @ec_strongify(self);
        self.ec_r = m_right;
        return self;
    };
}
-(UIView *(^)(CGFloat))ec_flexToRight {
    @ec_weakify(self);
    return ^(CGFloat m_flexToRight){
        @ec_strongify(self);
        self.ec_w += self.ec_r - m_flexToRight;
        return self;
    };
}

-(UIView *(^)(CGFloat))ec_width {
    @ec_weakify(self);
    return ^(CGFloat m_width){
        @ec_strongify(self);
        self.ec_w = m_width;
        return self;
    };
}
-(UIView *(^)(CGFloat))ec_height {
    @ec_weakify(self);
    return ^(CGFloat m_height){
        @ec_strongify(self);
        self.ec_h = m_height;
        return self;
    };
}

- (UIView *(^)(CGFloat))ec__centerX {
    @ec_weakify(self);
    return ^(CGFloat x){
        @ec_strongify(self);
        NSAssert(self.ec_w, @"must set width first");
        self.ec_centerX = x;
        return self;
    };
}

- (UIView *(^)(CGFloat))ec__centerY {
    @ec_weakify(self);
    return ^(CGFloat y){
        @ec_strongify(self);
        NSAssert(self.ec_h, @"must set height first");
        self.ec_centerY = y;
        return self;
    };
}

- (UIView *(^)(CGSize))ec_size {
    @ec_weakify(self);
    return ^(CGSize size){
        @ec_strongify(self);
        NSAssert(self.ec_size, @"must set size first");
        self.ec_s = size;
        return self;
    };
}

-(UIView *(^)(void))ec_center {
    @ec_weakify(self);
    return ^{
        @ec_strongify(self);
        if (self.superview) {
            self.ec_centerX = self.superview.ec_w / 2;
            self.ec_centerY = self.superview.ec_h / 2;
        }
        return self;
    };
}

-(UIView *(^)(void))ec_fill {
    @ec_weakify(self);
    return ^{
        @ec_strongify(self);
        if (self.superview) {
            self.ec_x = self.ec_y = 0;
            self.ec_w = self.superview.ec_w;
            self.ec_h = self.superview.ec_h;
        }
        return self;
    };
}

-(UIView *(^)(void))ec_sizeToFit {
    @ec_weakify(self);
    return ^{
        @ec_strongify(self);
        [self sizeToFit];
        return self;
    };
}

- (UIView * (^)(CGFloat space))ec_hstack {
    @ec_weakify(self);
    return ^(CGFloat space) {
        @ec_strongify(self);
        if (self.ec_sibling) {
            self.ec__centerY(self.ec_sibling.ec_centerY).ec_left(self.ec_sibling.ec_maxX+space);
        }
        return self;
    };
}

- (UIView * (^)(CGFloat space))ec_vstack {
    @ec_weakify(self);
    return ^(CGFloat space) {
        @ec_strongify(self);
        if (self.ec_sibling) {
            self.ec__centerX(self.ec_sibling.ec_centerX).ec_top(self.ec_sibling.ec_maxY+space);
        }
        return self;
    };
}

- (UIView *)ec_sibling {
    NSUInteger idx = [self.superview.subviews indexOfObject:self];
    if (idx == 0 || idx == NSNotFound)
        return nil;
    return self.superview.subviews[idx-1];
}

- (UIViewController *)ec_viewController {
    UIView *view = self;
    while (view) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
        view = view.superview;
      }
    return nil;
}



static void *kUIViewLayoutMethodPropertyBottomGap = &kUIViewLayoutMethodPropertyBottomGap;
static void *kUIViewLayoutMethodPropertyTopGap = &kUIViewLayoutMethodPropertyTopGap;
static void *kUIViewLayoutMethodPropertyLeftGap = &kUIViewLayoutMethodPropertyLeftGap;
static void *kUIViewLayoutMethodPropertyRightGap = &kUIViewLayoutMethodPropertyRightGap;

- (CGFloat)ec_safeAreaBottomGap
{
    NSNumber *gap = objc_getAssociatedObject(self, kUIViewLayoutMethodPropertyBottomGap);
    if (gap == nil) {
        if (@available(iOS 11, *)) {
            if (self.superview.safeAreaLayoutGuide.layoutFrame.size.height > 0) {
                gap = @((self.superview.ec_h - self.superview.safeAreaLayoutGuide.layoutFrame.origin.y - self.superview.safeAreaLayoutGuide.layoutFrame.size.height));
            } else {
                gap = nil;
            }
        } else {
            gap = @(0);
        }
        objc_setAssociatedObject(self, kUIViewLayoutMethodPropertyBottomGap, gap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gap.floatValue;
}

- (CGFloat)ec_safeAreaTopGap
{
    NSNumber *gap = objc_getAssociatedObject(self, kUIViewLayoutMethodPropertyTopGap);
    if (gap == nil) {
        if (@available(iOS 11, *)) {
            gap = @(self.superview.safeAreaLayoutGuide.layoutFrame.origin.y);
        } else {
            gap = @(0);
        }
        objc_setAssociatedObject(self, kUIViewLayoutMethodPropertyTopGap, gap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gap.floatValue;
}

- (CGFloat)ec_safeAreaLeftGap
{
    NSNumber *gap = objc_getAssociatedObject(self, kUIViewLayoutMethodPropertyLeftGap);
    if (gap == nil) {
        if (@available(iOS 11, *)) {
            gap = @(self.superview.safeAreaLayoutGuide.layoutFrame.origin.x);
        } else {
            gap = @(0);
        }
        objc_setAssociatedObject(self, kUIViewLayoutMethodPropertyLeftGap, gap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gap.floatValue;
}

- (CGFloat)ec_safeAreaRightGap
{
    NSNumber *gap = objc_getAssociatedObject(self, kUIViewLayoutMethodPropertyRightGap);
    if (gap == nil) {
        if (@available(iOS 11, *)) {
            gap = @((self.superview.ec_w - self.superview.safeAreaLayoutGuide.layoutFrame.origin.x - self.superview.safeAreaLayoutGuide.layoutFrame.size.width));
        } else {
            gap = @(0);
        }
        objc_setAssociatedObject(self, kUIViewLayoutMethodPropertyRightGap, gap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gap.floatValue;
}

@end

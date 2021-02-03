//
//  ECPlayerBackBottomView.m
//  ECPlayer
//
//  Created by chao on 2021/2/3.
//

#import "ECPlayerBackBottomView.h"

@interface ECPlayerBackBottomView ()

@property (strong, nonatomic) UIButton *playBtn;
@end

@implementation ECPlayerBackBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addChildViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self addChildViews];
    }
    return self;
}


- (void)addChildViews
{
    self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];

}
- (void)layoutFrame
{
    CGFloat selfHeight = CGRectGetHeight(self.frame);
    self.backBtn.frame = CGRectMake(0, (selfHeight-44)*0.5, 60, 44);
    self.titleLab.frame = CGRectMake(CGRectGetMaxX(self.backBtn.frame), (selfHeight-30)*0.5, 30, 0);
    [self.titleLab sizeToFit];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutFrame];
}

- (UIButton *)playBtn
{
    if (_playBtn == nil) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"player_back"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
@end

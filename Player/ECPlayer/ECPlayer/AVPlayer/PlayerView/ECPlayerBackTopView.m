//
//  ECPlayerBackTopView.m
//  ECPlayer
//
//  Created by chao on 2021/2/3.
//

#import "ECPlayerBackTopView.h"

@interface ECPlayerBackTopView ()

@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UIButton *backBtn;

@end

@implementation ECPlayerBackTopView

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
    [self addSubview:self.titleLab];
    [self addSubview:self.backBtn];
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

- (void)backClick:(UIButton *)sender
{
    
}


- (UILabel *)titleLab
{
    if (_titleLab == nil) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont fontWithName:@"PingFangSC" size:20];
        _titleLab.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _titleLab;
}
- (UIButton *)backBtn
{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"player_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
@end

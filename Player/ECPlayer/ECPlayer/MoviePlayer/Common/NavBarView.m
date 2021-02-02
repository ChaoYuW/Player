//
//  NavBarView.m
//  ChartView
//
//  Created by chao on 2021/2/2.
//

#import "NavBarView.h"

@interface NavBarView ()

@property (weak, nonatomic) IBOutlet UILabel *navLabel;

@end

@implementation NavBarView

+ (instancetype)navBarView
{
    NSString *className = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    
    CGFloat navHeight = 64;
    if (@available(iOS 11.0, *))
    {
            UIWindow *mainWindow = [[UIApplication sharedApplication].windows firstObject];
            if (mainWindow.safeAreaInsets.bottom > 0.0) {
                navHeight = 88;
            }
    }else
    {
        navHeight = 64;
    }
    NavBarView *view = [nib instantiateWithOwner:nil options:nil].firstObject;
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, navHeight);
    return view;
}
- (IBAction)closeClick:(UIButton *)sender {
    if (self.CloseBlock) {
        self.CloseBlock();
    }
}
- (void)setNavtitle:(NSString *)navtitle
{
    self.navLabel.text = navtitle;
}
@end

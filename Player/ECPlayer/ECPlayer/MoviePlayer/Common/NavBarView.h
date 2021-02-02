//
//  NavBarView.h
//  ChartView
//
//  Created by chao on 2021/2/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NavBarView : UIView

@property (copy, nonatomic) NSString *navtitle;

@property (copy, nonatomic) void (^CloseBlock)(void);
+ (instancetype)navBarView;
@end

NS_ASSUME_NONNULL_END

//
//  PlayerSlider.h
//  ECPlayer
//
//  Created by chao on 2021/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerPoint : NSObject
@property GLfloat where;
@property UIControl  *holder;
@property NSString *content;
@property NSInteger timeOffset;
@end

@protocol PlayerSliderDelegate <NSObject>
- (void)onPlayerPointSelected:(PlayerPoint *)point;
@end


@interface PlayerSlider : UISlider

@property NSMutableArray<PlayerPoint *> *pointArray;
@property UIProgressView *progressView;
@property (weak) id<PlayerSliderDelegate> delegate;
@property (nonatomic) BOOL hiddenPoints;

- (PlayerPoint *)addPoint:(GLfloat)where;

@end

NS_ASSUME_NONNULL_END

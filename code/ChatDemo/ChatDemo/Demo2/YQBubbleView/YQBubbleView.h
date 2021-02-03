//
//  YQBubbleView.h
//  ChatDemo
//
//  Created by 吴丹 on 2021/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^disappearBlock)(void);

@interface YQBubbleView : UILabel
/** 大圆脱离小圆的最大距离 */
@property (nonatomic, assign) CGFloat maxDistance;

/**
 按钮消失回调方法
 @param disappear 回调block
 */
- (void)disappear:(disappearBlock)disappear;
@end

NS_ASSUME_NONNULL_END

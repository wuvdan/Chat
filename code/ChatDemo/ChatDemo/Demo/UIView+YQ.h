//
//  UIView+YQ.h
//  ChatDemo
//
//  Created by wudan on 2021/2/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YQ)
@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

/// 高
@property CGFloat height;
/// 宽
@property CGFloat width;
/// Y坐标
@property CGFloat top;
/// X坐标
@property CGFloat left;
/// 底部 Y坐标+高度
@property CGFloat bottom;
/// 右侧 X坐标+宽度
@property CGFloat right;
@end

NS_ASSUME_NONNULL_END

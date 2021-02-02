//
//  InputToolBarView.h
//  ChatDemo
//
//  Created by wudan on 2021/2/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class InputToolBarView;
@protocol InputToolBarViewDelegate <NSObject>
/// 弹窗键盘或者操作视图
- (void)didShowOperationViewInIninputToolBarView:(InputToolBarView *)view;
/// 隐藏键盘或者操作视图
- (void)didDismissOperationViewInIninputToolBarView:(InputToolBarView *)view;
/// 文本输入监听
- (void)inputToolBarView:(InputToolBarView *)view didChangeText:(NSString *)text;
/// 操作更多监听
- (void)didTappedMoreButtonIninputToolBarView:(InputToolBarView *)view;
@end

@interface InputToolBarView : UIView
/// 操作回调
@property (nonatomic, weak) id<InputToolBarViewDelegate> delegate;
/// 语音
@property (nonatomic, strong) UIButton *voiceButton;
/// 输入框
@property (nonatomic, strong) UITextView *textView;
/// 表情
@property (nonatomic, strong) UIButton *emojiButton;
/// 更多
@property (nonatomic, strong) UIButton *moreButton;
/// 工具栏
@property (nonatomic, strong) UIView *toolBarView;
/// 背景视图
@property (nonatomic, strong) UIView *backgroundView;

/// 列表下滑时隐藏操作栏
- (void)dismissViewByDrag;

/// 添加子视图
/// @param view 添加在backgroundView
/// @param height 显示高度
- (void)addOperationView:(UIView *)view viewHeight:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END

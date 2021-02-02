//
//  InputToolBarView.m
//  ChatDemo
//
//  Created by wudan on 2021/2/1.
//

#import "InputToolBarView.h"
#import <Masonry.h>
#import <CoreText/CoreText.h>
#import "EmojiView.h"
#import "VoiceView.h"

#define kSafeAreaBottom ([UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom)

@interface InputToolBarView ()<UITextViewDelegate>
{
    CGFloat _keybordHeight;
    CGFloat _textViewHeight;
    CGFloat _operationViewHeight;
}
@property (nonatomic, strong) EmojiView *emojiView;
@property (nonatomic, strong) VoiceView *voiceView;
@end

@implementation InputToolBarView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
 
- (instancetype)init {
    self = [super init];
    if (self) {
        _keybordHeight = 0;
        _textViewHeight = 40;
        _operationViewHeight = 0;
        [self setupView];
        [self setupViewConstraints];
        [self addNotification];
    }
    return self;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Notification

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:[curve doubleValue]];
    _keybordHeight = keyboardRect.size.height;
    _operationViewHeight = 0;
    [self.backgroundView.subviews.firstObject removeFromSuperview];
    [self updataBackgroundViewHeight];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didShowOperationViewInIninputToolBarView:)]) {
        [self.delegate didShowOperationViewInIninputToolBarView:self];
    }
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    _keybordHeight = 0;
    [self updataBackgroundViewHeight];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    CGFloat textViewHeight = [self getHeightOfTextView:textView.text];
    if (textViewHeight <= 40) {
        textViewHeight = 40;
    } else if (textViewHeight <= 100) {
        textViewHeight = [self getHeightOfTextView:textView.text];
    } else {
        textViewHeight = 100;
    }

    _textViewHeight = textViewHeight;
        
    [self updataToolBarViewHeight];
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputToolBarView:didChangeText:)]) {
        [self.delegate inputToolBarView:self didChangeText:textView.text];
    }
}

#pragma mark - Event

- (void)didTappedVoiceButtonAction:(id)sender {
    [self addOperationView:self.voiceView viewHeight:250];
}

- (void)didTappedEmojiButtonAction:(id)sender {
    [self addOperationView:self.emojiView viewHeight:280];
}

- (void)didTappedMoreButtonAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTappedMoreButtonIninputToolBarView:)]) {
        [self.delegate didTappedMoreButtonIninputToolBarView:self];
    }
}

#pragma mark - Set up view

- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backgroundView];
    [self addSubview:self.toolBarView];
    [self.toolBarView addSubview:self.voiceButton];
    [self.toolBarView addSubview:self.emojiButton];
    [self.toolBarView addSubview:self.textView];
    [self.toolBarView addSubview:self.moreButton];
}

- (void)setupViewConstraints {
    [self.toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(self.backgroundView.mas_top);
    }];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kSafeAreaBottom);
    }];
    
    [self.voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.width.height.mas_equalTo(30);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.emojiButton.mas_trailing).mas_offset(10);
        make.width.height.mas_equalTo(30);
        make.bottom.mas_equalTo(-10);
        make.trailing.mas_equalTo(-15);
    }];
    
    [self.emojiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.moreButton.mas_leading).mas_offset(-10);
        make.width.height.mas_equalTo(30);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.voiceButton.mas_trailing).mas_offset(10);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-5);
        make.trailing.mas_equalTo(self.emojiButton.mas_leading).mas_offset(-10);
    }];
}

#pragma mark - Update View

/// 输入框输入后，更新顶部输入框和输入框父视图高度
- (void)updataToolBarViewHeight {
    [self.toolBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self->_textViewHeight + 10);
    }];
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self->_textViewHeight);
    }];
    
    [self updataSelfHeight];
        
    [UIView animateWithDuration:0.1 animations:^{
        [self.toolBarView.superview layoutIfNeeded];
        [self.textView.superview layoutIfNeeded];
        [self.superview layoutIfNeeded];
    }];
}

/// 更新底部操作视图高度
- (void)updataBackgroundViewHeight {
    if (_keybordHeight == 0 && _operationViewHeight == 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didShowOperationViewInIninputToolBarView:)]) {
            [self.delegate didDismissOperationViewInIninputToolBarView:self];
        }
    }
        
    [self.backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self->_keybordHeight == 0 && self->_operationViewHeight == 0) {
            make.height.mas_equalTo(kSafeAreaBottom);
        } else if (self->_keybordHeight > 0 && self->_operationViewHeight == 0) {
            make.height.mas_equalTo(self->_keybordHeight);
        } else if (self->_operationViewHeight > 0 && self->_keybordHeight == 0) {
            make.height.mas_equalTo(self->_operationViewHeight + kSafeAreaBottom);
        } else {
            make.height.mas_equalTo(self->_keybordHeight);
        }
    }];
    
    [self updataSelfHeight];
    
    [UIView animateWithDuration:0.25 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        [self.superview layoutIfNeeded];
        [self.backgroundView.superview layoutIfNeeded];
    } completion:nil];
}

/// 更新当前View高度
- (void)updataSelfHeight {
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self->_keybordHeight == 0 && self->_operationViewHeight == 0) {
            make.height.mas_equalTo(kSafeAreaBottom + self->_textViewHeight + 10);
        } else if (self->_keybordHeight > 0 && self->_operationViewHeight == 0) {
            make.height.mas_equalTo(self->_keybordHeight + self->_textViewHeight + 10);
        } else if (self->_operationViewHeight > 0 && self->_keybordHeight == 0) {
            make.height.mas_equalTo(self->_operationViewHeight + self->_textViewHeight + 10 + kSafeAreaBottom);
        } else {
            make.height.mas_equalTo(self->_keybordHeight + self->_textViewHeight + 10);
        }
    }];
}

#pragma mark - Public Methods
/// 列表页滑动，隐藏操作栏与键盘
- (void)dismissViewByDrag{
    _keybordHeight = 0;
    _operationViewHeight = 0;
    [self.backgroundView.subviews.firstObject removeFromSuperview];
    [self updataBackgroundViewHeight];
    [self.textView resignFirstResponder];
}

/// 添加视图
- (void)addOperationView:(UIView *)view viewHeight:(CGFloat)height {
    [self.backgroundView.subviews.firstObject removeFromSuperview];
    _operationViewHeight = height;
    [self.backgroundView addSubview:view];
    view.frame = CGRectMake(0, 0, CGRectGetWidth(self.backgroundView.bounds), height);
    [self updataBackgroundViewHeight];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didShowOperationViewInIninputToolBarView:)]) {
        [self.delegate didShowOperationViewInIninputToolBarView:self];
    }
    [self.textView resignFirstResponder];
}

#pragma mark - Tool
/// 计算文本高度
- (CGFloat)getHeightOfTextView:(NSString *)calcedString {
    CGSize limitSize = CGSizeMake(self.textView.bounds.size.width - 10, 150);
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineSpacing = 2;
    NSMutableAttributedString *attibuteStr = [[NSMutableAttributedString alloc] initWithString:calcedString];
    [attibuteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.5] range:NSMakeRange(0, calcedString.length)];
    [attibuteStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, calcedString.length)];
    CFAttributedStringRef attributedStringRef = (__bridge CFAttributedStringRef)attibuteStr;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attributedStringRef);
    CFRange range = CFRangeMake(0, calcedString.length);
    CFRange fitCFRange = CFRangeMake(0, 0);
    CGSize newSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, NULL, limitSize, &fitCFRange);
    if (nil != framesetter) {
        CFRelease(framesetter);
        framesetter = nil;
    }
    return ceilf(newSize.height);
}

#pragma mark - Getter
- (UIButton *)voiceButton {
    if (!_voiceButton) {
        _voiceButton = [[UIButton alloc] init];
        [_voiceButton setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
        [_voiceButton addTarget:self action:@selector(didTappedVoiceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (UIButton *)emojiButton {
    if (!_emojiButton) {
        _emojiButton = [[UIButton alloc] init];
        [_emojiButton setImage:[UIImage imageNamed:@"emoji"] forState:UIControlStateNormal];
        [_emojiButton addTarget:self action:@selector(didTappedEmojiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojiButton;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(didTappedMoreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:15.5];
        _textView.delegate = self;
        _textView.layer.cornerRadius = 3;
        _textView.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
        _textView.returnKeyType = UIReturnKeySend;
        _textView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return _textView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backgroundView;
}

- (UIView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [[UIView alloc] init];
        _toolBarView.backgroundColor = [UIColor whiteColor];
    }
    return _toolBarView;
}

- (EmojiView *)emojiView {
    if (!_emojiView) {
        _emojiView = [[EmojiView alloc] init];
        _emojiView.backgroundColor = [UIColor systemPinkColor];
    }
    return _emojiView;
}

- (VoiceView *)voiceView {
    if (!_voiceView) {
        _voiceView = [[VoiceView alloc] init];
        _voiceView.backgroundColor = [UIColor greenColor];
    }
    return _voiceView;
}
@end

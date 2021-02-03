//
//  ConversationRightTextTableViewCell.m
//  ChatDemo
//
//  Created by wudan on 2021/2/3.
//

#import "ConversationRightTextTableViewCell.h"
#import <Masonry.h>

@implementation ConversationRightTextTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
        [self setupViewConstraints];
    }
    return self;
}

#pragma mark - Set up view

- (void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.errorSendButton];
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showMenuAction:)];
    [self.contentLabel setUserInteractionEnabled:YES];
    [self.contentLabel addGestureRecognizer:longGesture];
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)selector withSender:(id) sender {
    if (selector == @selector(copyAction:)) {
        return YES;
    }
    
    if (selector == @selector(deleteAction:)) {
        return YES;
    }
    return NO;
}

- (void)copyAction:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.contentLabel.text];
}

- (void)deleteAction:(id)sender {

}

- (void)showMenuAction:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteAction:)];
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyAction:)];
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        menuController.menuItems = @[deleteItem, copyItem];
        [menuController setTargetRect:self.contentLabel.bounds inView:self.contentLabel];
        [menuController setMenuVisible:YES animated:YES];
    }
}

- (void)setupViewConstraints {
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_greaterThanOrEqualTo(40 + 15 + 25);
        make.trailing.mas_equalTo(self.headerImageView.mas_leading).mas_offset(-20);
        make.top.mas_equalTo(self.headerImageView).mas_offset(15);
        make.bottom.mas_equalTo(-28);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.contentLabel).mas_offset(-12);
        make.trailing.bottom.mas_equalTo(self.contentLabel).mas_offset(12);
    }];
    
    [self.errorSendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.backView);
        make.trailing.mas_equalTo(self.backView.mas_leading).mas_offset(-8);
        make.width.height.mas_equalTo(17);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetMaxX(self.backView.frame), CGRectGetMinY(self.backView.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(self.backView.frame) + 2, CGRectGetMinY(self.backView.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(self.backView.frame), CGRectGetMinY(self.backView.frame) + 8)];
    
    UIColor *fillColor = [UIColor colorWithRed:204/255.0 green:223/255.0 blue:255/255.0 alpha:1.0];
    [fillColor set];
    [path fill];
    path.lineWidth = 0;
    [path closePath];
    [path stroke];
}

#pragma mark - Getter
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _contentLabel;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImageView.clipsToBounds = YES;
        _headerImageView.layer.cornerRadius = 20;
        _headerImageView.layer.masksToBounds = YES;
    }
    return _headerImageView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.cornerRadius = 5;
        _backView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMaxYCorner | kCALayerMinXMaxYCorner;
        _backView.backgroundColor = [UIColor colorWithRed:204/255.0 green:223/255.0 blue:255/255.0 alpha:1.0];
    }
    return _backView;
}

- (UIButton *)errorSendButton {
    if (!_errorSendButton) {
        _errorSendButton = [[UIButton alloc] init];
        [_errorSendButton setImage:[UIImage imageNamed:@"发送失败"] forState:UIControlStateNormal];
    }
    return _errorSendButton;
}

@end

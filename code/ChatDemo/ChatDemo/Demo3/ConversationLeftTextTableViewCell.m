//
//  ConversationLeftTextTableViewCell.m
//  ChatDemo
//
//  Created by wudan on 2021/2/3.
//

#import "ConversationLeftTextTableViewCell.h"
#import <Masonry.h>

@implementation ConversationLeftTextTableViewCell

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
    
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showMenuAction:)];
    [self.contentLabel setUserInteractionEnabled:YES];
    [self.contentLabel addGestureRecognizer:longGesture];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetMinX(self.backView.frame), CGRectGetMinY(self.backView.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetMinX(self.backView.frame) - 2, CGRectGetMinY(self.backView.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetMinX(self.backView.frame), CGRectGetMinY(self.backView.frame) + 8)];

    UIColor *fillColor = [UIColor whiteColor];
    [fillColor set];
    path.lineWidth = 0;
    [path fill];
    [path closePath];
    [path stroke];
}


- (void)setupViewConstraints {
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_lessThanOrEqualTo(-(40 + 15 + 25));
        make.leading.mas_equalTo(self.headerImageView.mas_trailing).mas_offset(20);
        make.top.mas_equalTo(self.headerImageView).mas_offset(15);
        make.bottom.mas_equalTo(-28);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.contentLabel).mas_offset(-12);
        make.trailing.bottom.mas_equalTo(self.contentLabel).mas_offset(12);
    }];
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)selector withSender:(id) sender {
    if (selector == @selector(copyAction:)) {
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
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyAction:)];
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        menuController.menuItems = @[copyItem];
        [menuController setTargetRect:self.contentLabel.bounds inView:self.contentLabel];
        [menuController setMenuVisible:YES animated:YES];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Getter
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
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
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 5;
        _backView.layer.maskedCorners = kCALayerMaxXMinYCorner | kCALayerMaxXMaxYCorner | kCALayerMinXMaxYCorner;
    }
    return _backView;
}
@end

//
//  ConversationListCell.m
//  ChatDemo
//
//  Created by wudan on 2021/2/3.
//

#import "ConversationListCell.h"
#import <Masonry.h>

@implementation ConversationListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
        [self setupViewConstraints];
    }
    return self;
}

#pragma mark - Set up view

- (void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.topTagImageView];
    [self.contentView addSubview:self.bubbleView];
}

- (void)setupViewConstraints {
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.headerImageView.mas_trailing).mas_offset(10);
        make.bottom.mas_equalTo(self.headerImageView.mas_centerY).mas_offset(-5);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.nameLabel);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.headerImageView.mas_trailing).mas_offset(10);
        make.top.mas_equalTo(self.headerImageView.mas_centerY).mas_offset(5);
        make.trailing.mas_equalTo(-15);
    }];
    
    [self.bubbleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.width.height.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentLabel);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Getter
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

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.numberOfLines = 1;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 1;
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _contentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.numberOfLines = 1;
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

- (UIImageView *)topTagImageView {
    if (!_topTagImageView) {
        _topTagImageView = [[UIImageView alloc] init];
        _topTagImageView.contentMode = UIViewContentModeScaleAspectFit;
        _topTagImageView.image = [UIImage imageNamed:@""];
    }
    return _topTagImageView;
}

- (YQBubbleView *)bubbleView {
    if (!_bubbleView) {
        _bubbleView = [[YQBubbleView alloc] init];
        _bubbleView.textAlignment = NSTextAlignmentCenter;
        _bubbleView.textColor = [UIColor whiteColor];
        _bubbleView.font = [UIFont systemFontOfSize:10];
    }
    return _bubbleView;
}

@end

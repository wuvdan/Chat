//
//  ConversationTimeTableViewCell.m
//  ChatDemo
//
//  Created by 吴丹 on 2021/2/3.
//

#import "ConversationTimeTableViewCell.h"
#import <Masonry.h>

@implementation ConversationTimeTableViewCell

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
    [self.contentView addSubview:self.timeLabel];
}

- (void)setupViewConstraints {
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.bottom.equalTo(self.contentView).inset(12);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Getter
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.numberOfLines = 1;
        _timeLabel.textColor = [UIColor colorWithRed:134/255.0 green:140/255.0 blue:154/255.0 alpha:1.0];
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}
@end

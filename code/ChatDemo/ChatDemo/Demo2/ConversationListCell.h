//
//  ConversationListCell.h
//  ChatDemo
//
//  Created by wudan on 2021/2/3.
//

#import <UIKit/UIKit.h>
#import "YQBubbleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConversationListCell : UITableViewCell
/// 头像
@property (nonatomic, strong) UIImageView *headerImageView;
/// 姓名
@property (nonatomic, strong) UILabel *nameLabel;
/// 内容
@property (nonatomic, strong) UILabel *contentLabel;
/// 时间
@property (nonatomic, strong) UILabel *timeLabel;
/// 置顶标注
@property (nonatomic, strong) UIImageView *topTagImageView;
///  红点
@property (nonatomic, strong) YQBubbleView *bubbleView;
@end

NS_ASSUME_NONNULL_END

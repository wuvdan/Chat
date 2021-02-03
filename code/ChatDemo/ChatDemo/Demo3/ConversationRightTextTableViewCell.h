//
//  ConversationRightTextTableViewCell.h
//  ChatDemo
//
//  Created by wudan on 2021/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConversationRightTextTableViewCell : UITableViewCell
/// 内容
@property (nonatomic, strong) UILabel *contentLabel;
/// 头像
@property (nonatomic, strong) UIImageView *headerImageView;
/// 内容背景
@property (nonatomic, strong) UIView *backView;
/// 发送失败按钮
@property (nonatomic, strong) UIButton *errorSendButton;
/// 文件取消发送按钮
@property (nonatomic, strong) UIButton *cancelSendButton;
@end

NS_ASSUME_NONNULL_END

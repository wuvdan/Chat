//
//  ConversationListViewController.m
//  ChatDemo
//
//  Created by wudan on 2021/2/3.
//

/**
 * 使用说明：
 *  <#.......#>
 */

#import "ConversationListViewController.h"
#import "ConversationListCell.h"
#import <Masonry.h>
#import <SDWebImage.h>

@interface ConversationListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ConversationListViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    [self setupView];
    [self setupViewConstraints];
}

#pragma mark - Delegate
#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConversationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversationListCell" forIndexPath:indexPath];
    [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3317240047,2073069235&fm=11&gp=0.jpg"]];
    cell.nameLabel.text = @"张三";
    cell.contentLabel.text = @"明天来我家吃饭？";
    cell.timeLabel.text = @"2月1日";
    cell.bubbleView.text = @"3";
    [cell.bubbleView disappear:^{
        NSLog(@"%@", indexPath);
    }];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction * action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    }];
    action.backgroundColor = [UIColor redColor];
    
    UITableViewRowAction * action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    }];
    action1.backgroundColor = [UIColor lightGrayColor];
    return @[action, action1];
}
#pragma mark - Event

#pragma mark - Network

#pragma mark - Set up view

- (void)setupNavBar {
    self.title = @"Conversation List";
}

- (void)setupView {
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self.view addSubview:self.tableView];
}

- (void)setupViewConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 66;
        _tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:NSClassFromString(@"ConversationListCell") forCellReuseIdentifier:@"ConversationListCell"];
    }
    return _tableView;
}
@end

//
//  ConversationViewController.m
//  ChatDemo
//
//  Created by wudan on 2021/2/3.
//

/**
 * 使用说明：
 *  <#.......#>
 */

#import "ConversationViewController.h"
#import "ConversationRightTextTableViewCell.h"
#import <SDWebImage.h>
#import <Masonry.h>
#import "ConversationLeftTextTableViewCell.h"
#import "ConversationTimeTableViewCell.h"


@interface ConversationViewController ()<UITableViewDelegate, UITableViewDataSource>
/// 列表
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ConversationViewController

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
    if (indexPath.row == 0) {
        ConversationTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversationTimeTableViewCell" forIndexPath:indexPath];
        cell.timeLabel.text = @"12:02";
        return cell;
    }
    if (indexPath.row % 2 == 0) {
        ConversationLeftTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversationLeftTextTableViewCell" forIndexPath:indexPath];
        [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201509%2F16%2F20150916235818_HVAk2.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1614931905&t=2d8b9b5cafbd7f8686d0be604aa11b39"]];
        cell.contentLabel.text = @"在整个动画时间内动画都是以一个相同的速度来改变。也就是匀速运动。一个线性的计时函数，同样也是CAAnimation的timingFunction属性为空时候的默认函数。线性步调对于那些立即加速并且保持匀速到达终点的场景会有意义（例如射出枪膛的子弹）。kCAMediaTimingFunctionEaseIn";
        return cell;
    } else {
        ConversationRightTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversationRightTextTableViewCell" forIndexPath:indexPath];
        [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://gss0.baidu.com/70cFfyinKgQFm2e88IuM_a/forum/w=580/sign=580e773405f431adbcd243317b37ac0f/50f2f9dde71190ef9c7f0079c71b9d16fffa60dc.jpg"]];
        cell.contentLabel.text = @"牛逼啊";
        return cell;
    }
}
#pragma mark - Event

#pragma mark - Network

#pragma mark - Set up view

- (void)setupNavBar {
    self.title = @"张三";
}

- (void)setupView {
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
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
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100.f;
        _tableView.backgroundColor = [UIColor colorWithRed:246/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:NSClassFromString(@"ConversationRightTextTableViewCell") forCellReuseIdentifier:@"ConversationRightTextTableViewCell"];
        [_tableView registerClass:NSClassFromString(@"ConversationLeftTextTableViewCell") forCellReuseIdentifier:@"ConversationLeftTextTableViewCell"];
        [_tableView registerClass:NSClassFromString(@"ConversationTimeTableViewCell") forCellReuseIdentifier:@"ConversationTimeTableViewCell"];
    }
    return _tableView;
}

@end

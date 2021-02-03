//
//  InputViewController.m
//  ChatDemo
//
//  Created by wudan on 2021/2/1.
//

/**
 * 使用说明：
 *  参考钉钉：
 *  1. 输入框有报错的文字时，键盘需要弹起
 *  2. 文字长度5行
 */

#import "InputViewController.h"
#import "InputToolBarView.h"
#import <Masonry.h>
#import "UIView+YQ.h"
#import "TestView.h"
#import "ConversationRightTextTableViewCell.h"
#import <SDWebImage.h>
#import "ConversationLeftTextTableViewCell.h"
#import "ConversationTimeTableViewCell.h"

@interface InputViewController ()<UITableViewDelegate, UITableViewDataSource, InputToolBarViewDelegate>
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) InputToolBarView *inputToolBarView;
@property (nonatomic, assign) CGFloat lastOffSetY;
@property (nonatomic, assign) BOOL showKeybord;
@end

@implementation InputViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    [self setupView];
    [self setupViewConstraints];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] -1 inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastOffSetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y - self.lastOffSetY > 0) {
        
    } else {
        if (scrollView.tracking && self.showKeybord) {
            [self.inputToolBarView dismissViewByDrag];
        }
    }
}

#pragma mark InputToolBarViewDelegate

- (void)inputToolBarView:(InputToolBarView *)view didChangeText:(NSString *)text {
    
}

- (void)didTappedMoreButtonIninputToolBarView:(InputToolBarView *)view {
    TestView *testView = [[TestView alloc] init];
    [view addOperationView:testView viewHeight:500];
}

- (void)didShowOperationViewInIninputToolBarView:(InputToolBarView *)view {
    self.showKeybord = YES;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] -1 inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}

- (void)didDismissOperationViewInIninputToolBarView:(InputToolBarView *)view {
    self.showKeybord = NO;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] -1 inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}

#pragma mark - Event

#pragma mark - Network

#pragma mark - Set up view

- (void)setupNavBar {
    self.title = @"张三";
}

- (void)setupView {
    self.showKeybord = NO;
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
    [self.view addSubview:self.stackView];
}

- (void)setupViewConstraints {
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.inputToolBarView.mas_top);
    }];
    
    [self.inputToolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(50 + [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - Getter
- (InputToolBarView *)inputToolBarView {
    if (!_inputToolBarView) {
        _inputToolBarView = [[InputToolBarView alloc] init];
        _inputToolBarView.delegate = self;
    }
    return _inputToolBarView;
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
- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.tableView, self.inputToolBarView]];
        _stackView.distribution = UIStackViewDistributionFill;
        _stackView.alignment = UIStackViewAlignmentCenter;
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 0;
    }
    return _stackView;
}

@end

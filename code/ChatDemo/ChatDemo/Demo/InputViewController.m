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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"cell->%ld", indexPath.row + 1];
    if (indexPath.row % 2 == 1) {
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    } else {
        cell.textLabel.textAlignment = NSTextAlignmentRight;
    }
    cell.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    return cell;
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
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
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

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100.f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:NSClassFromString(@"UITableViewCell") forCellReuseIdentifier:@"UITableViewCell"];
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

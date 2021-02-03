//
//  ViewController.m
//  ChatDemo
//
//  Created by wudan on 2021/2/1.
//

#import "ViewController.h"

#import "InputViewController.h"
#import "ConversationListViewController.h"
#import "ConversationViewController.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray<NSString *> *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.dataSource = @[@"输入框", @"聊天列表", @"聊天页面"];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            InputViewController *vc = [[InputViewController alloc] init];
            [self.navigationController showViewController:vc sender:nil];
        }
            break;
        case 1:
        {
            ConversationListViewController *vc = [[ConversationListViewController alloc] init];
            [self.navigationController showViewController:vc sender:nil];
        }
            break;
        case 2:
        {
            ConversationViewController *vc = [[ConversationViewController alloc] init];
            [self.navigationController showViewController:vc sender:nil];
        }
        default:
            break;
    }
}

@end

//
//  VoiceView.m
//  ChatDemo
//
//  Created by wudan on 2021/2/2.
//

#import "VoiceView.h"

@implementation VoiceView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
        [self setupViewConstraints];
    }
    return self;
}

#pragma mark - Set up view

- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setupViewConstraints {
    
}

#pragma mark - Getter

@end

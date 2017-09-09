//
//  MultiSelectionContentView.m
//  SRAlertViewDemo
//
//  Created by 王虎 on 2017/9/4.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "MultiSelectionContentView.h"

#import <Masonry/Masonry.h>

@interface MultiSelectionContentView ()
/** 展示项*/
@property (copy, nonatomic) NSArray<NSString *> *items;

/** 标题*/
@property (copy, nonatomic) NSString *title;

@property (assign, nonatomic) NSUInteger cancelButtonTag;

@end

@implementation MultiSelectionContentView

- (instancetype)initWithItems:(NSArray<NSString *> *)items
                        Title:(NSString *)title{
    _items = items;
    _title = title;
    self = [super init];
    [self autoLayoutUI];
    return self;
}

- (void)autoLayoutUI{
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:16];
    // 12 75 137
    titleLabel.textColor = [UIColor colorWithRed:12.0 / 255.0 green:75.0/ 255.0 blue:137.0/ 255.0 alpha:1.0];
    titleLabel.text = self.title;

    NSUInteger index = 0;
    UIButton *lastButton = nil;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(60);
    }];

    for (NSString *item in self.items) {
        MASViewAttribute *refrenceAttribute = ((lastButton != nil)?lastButton.mas_bottom : self.mas_top);
        CGFloat spacing = (lastButton != nil)?16:106;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self action:@selector(buttonClickedHandler:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:item forState:UIControlStateNormal];
        [button setTag:index];
        button.layer.cornerRadius = 26.0;
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.height.mas_equalTo(56);
            make.top.equalTo(refrenceAttribute).offset(spacing);
        }];

        lastButton = button;
        // rgb 58 146 252
        [button setBackgroundColor:[UIColor colorWithRed:58.0 / 255.0 green:146.0 / 255.0 blue:252.0 / 255.0 alpha:1.0]];
        index += 1;
    }

    self.cancelButtonTag = index - 1;

}


- (void)buttonClickedHandler:(UIButton *)sender{
    NSLog(@"--tag:%zd", sender.tag);
    if (sender.tag == self.cancelButtonTag) {
        // dismiss
        [self dismissHandler];
    }else{
        [self commitCommentsHandler:sender.tag];
    }
}

- (void)commitCommentsHandler:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(commitComments:)]) {
        NSString *selectComment = self.items[index];
        NSDictionary<NSString*, NSString*> *comments = @{
                                                    @"selectComment":selectComment
                                                         };
        [self.delegate commitComments:comments];
    }
}

- (void)dismissHandler{
    if ([self.delegate respondsToSelector:@selector(cancelButtonClicked)]) {
        [self.delegate cancelButtonClicked];
    }
}



@end

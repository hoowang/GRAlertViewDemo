//
//  SexualOrientationContentView.m
//  SRAlertViewDemo
//
//  Created by 王虎 on 2017/9/4.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "SexualOrientationContentView.h"

@implementation SexualOrientationContentView

- (instancetype)init{
    NSArray *items = @[@"来个妹纸", @"来个汉纸", @"都行/不明", @"取消"];
    self = [super initWithItems:items Title:@"你的恋爱倾向"];
    return self;
}


@end

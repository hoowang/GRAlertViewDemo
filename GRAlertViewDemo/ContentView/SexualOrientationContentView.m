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
    NSArray *items = @[@"中秋节", @"元旦节", @"劳动节", @"取消"];
    self = [super initWithItems:items Title:@"哪个假期最长"];
    return self;
}


@end

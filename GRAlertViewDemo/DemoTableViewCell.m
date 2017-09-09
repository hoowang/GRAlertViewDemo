//
//  DemoTableViewCell.m
//  GRAlertViewDemo
//
//  Created by 王虎 on 2017/9/9.
//  Copyright © 2017年 Linyun. All rights reserved.
//

#import "DemoTableViewCell.h"

@implementation DemoTableViewCell

+ (NSString *)reuseableIdentifier{
    return NSStringFromClass([self class]);
}

- (void)setText:(NSString *)text{
    self.textLabel.text = text;
}

@end

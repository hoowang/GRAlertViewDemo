//
//  DemoTableViewCell.h
//  GRAlertViewDemo
//
//  Created by 王虎 on 2017/9/9.
//  Copyright © 2017年 Linyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoTableViewCell : UITableViewCell

+ (NSString *)reuseableIdentifier;

- (void)setText:(NSString *)text;

@end

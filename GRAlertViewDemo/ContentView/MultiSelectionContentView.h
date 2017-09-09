//
//  MultiSelectionContentView.h
//  SRAlertViewDemo
//
//  Created by 王虎 on 2017/9/4.
//  Copyright © 2017年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MultiSelectViewProtocol <NSObject>

@required
- (void)cancelButtonClicked;
- (void)commitComments:(NSDictionary<NSString*, NSString*> *_Nonnull)comments;
@end

@interface MultiSelectionContentView : UIView

@property (weak, nonatomic, nullable) id<MultiSelectViewProtocol> delegate;

- (instancetype _Nonnull )initWithItems:(NSArray<NSString *> *_Nonnull)items
                        Title:(NSString *_Nonnull)title;

@end

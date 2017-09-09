//
//  SRAlertView.h
//  SRAlertView
//
//  Created by https://github.com/hoowang/GRAlertViewDemo16/7/8.
//  Copyright © 2016年 hooge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRAlertView;

typedef NS_ENUM(NSInteger, GRAlertViewActionType) {
    GRAlertViewActionTypeLeft,
    GRAlertViewActionTypeRight,
};

typedef NS_ENUM(NSInteger, GRAlertViewAnimationStyle) {
    GRAlertViewAnimationNone,
    GRAlertViewAnimationZoomSpring,
    GRAlertViewAnimationTopToCenterSpring,
    GRAlertViewAnimationDownToCenterSpring,
    GRAlertViewAnimationLeftToCenterSpring,
    GRAlertViewAnimationRightToCenterSpring,
};

@interface GRAlertView : UIView

/**
 Whether blur the current background view, default is YES.
 */
@property (nonatomic, assign) BOOL blurEffect;

/**
 The animation style of showing the alert view.
 */
@property (nonatomic, assign) GRAlertViewAnimationStyle animationStyle;


/** 
 top display image name 
 */
@property (copy, nonatomic, nullable) NSString *topImageName;


+ (instancetype _Nonnull )alertViewWithContentView:(UIView *_Nonnull)contentView
                              ViewHeight:(CGFloat)height
                               ViewWidth:(CGFloat)width;

- (instancetype _Nonnull )initWithContentView:(UIView *_Nonnull)contentView
                                ViewHeight:(CGFloat)height
                                 ViewWidth:(CGFloat)width;

- (void)present:(UIViewController *_Nonnull)controller;
- (void)presentOnWindow;
- (void)dismiss;

@end

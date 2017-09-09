//
//  SRAlertView.m
//  SRAlertView
//
//  Created by https://github.com/hoowang/GRAlertViewDemo16/7/8.
//  Copyright © 2016年 hooge. All rights reserved.
//

#import "GRAlertView.h"
#import "FXBlurView.h"

#pragma mark - Frames

#define SCREEN_BOUNDS         [UIScreen mainScreen].bounds
#define SCREEN_WIDTH          [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT         [UIScreen mainScreen].bounds.size.height
#define SCREEN_ADJUST(Value)  SCREEN_WIDTH * (Value) / 375.0f

#define kAlertViewW            275.0f
#define kLineBackgroundColor  [UIColor colorWithRed:1.00 green:0.92 blue:0.91 alpha:1.00]
#define kBlurRadius  10.0

@interface GRAlertView ()

@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, strong) UIView     *coverView;
@property (nonatomic, strong) UIView *alertView;

/** contentView*/
@property (weak, nonatomic) UIView *contentView;

/** viewHeight*/
@property (assign, nonatomic)  CGFloat viewHeight;

/** viewWidht*/
@property (assign, nonatomic)  CGFloat viewWidth;

@end

@implementation GRAlertView


+ (instancetype)alertViewWithContentView:(UIView *)contentView
                              ViewHeight:(CGFloat)height
                               ViewWidth:(CGFloat)width{

    GRAlertView *alertView = [[GRAlertView alloc]
                              initWithContentView:contentView
                              ViewHeight:height
                              ViewWidth:width];
    return alertView;
}


#pragma mark - Setup UI

- (FXBlurView *)blurView {
    if (!_blurView) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.33];
        _blurView = [[FXBlurView alloc] initWithFrame:SCREEN_BOUNDS];
        _blurView.tintColor = [UIColor clearColor];
        _blurView.dynamic = NO;
        _blurView.blurRadius = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:_blurView];
    }
    return _blurView;
}

- (UIView *)coverView {
    
    if (!_coverView) {
        [self insertSubview:({
            _coverView = [[UIView alloc] initWithFrame:self.bounds];
            _coverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.33];
            _coverView.alpha = 0;
            _coverView;
        }) atIndex:0];
    }
    return _coverView;
}

- (instancetype)initWithContentView:(UIView *)contentView
                              ViewHeight:(CGFloat)height
                               ViewWidth:(CGFloat)width{
    self = [super initWithFrame:SCREEN_BOUNDS];
    _contentView = contentView;
    _viewHeight = height;
    _viewWidth = width;
    _blurEffect       = YES;
    _animationStyle   = GRAlertViewAnimationZoomSpring;
    //[self setupAlertView];

    return self;
}

- (void)setupAlertView {
    
    [self addSubview:({
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 10.0;
        _alertView.layer.masksToBounds = YES;
        _alertView;
    })];

    if (self.viewWidth == 0) {
        self.viewWidth = 284;
    }

    if (self.viewHeight == 0) {
        self.viewHeight = 332;
    }

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.topImageName]];
    imageView.clipsToBounds = YES;
    [imageView sizeToFit];
    _alertView.frame = CGRectMake(0, 0, self.viewWidth, self.viewHeight );
    _alertView.center = self.center;
    [_alertView addSubview:self.contentView];
    _contentView.frame = CGRectMake(0, 0, _alertView.frame.size.width , self.viewHeight);

    _alertView.clipsToBounds = NO;
    [_alertView addSubview:imageView];
    
    CGFloat imageViewX = (_alertView.frame.size.width - imageView.frame.size.width) * 0.5;
    CGFloat imageViewY = 0 - imageView.frame.size.height * 0.5;
    imageView.frame = CGRectMake(imageViewX, imageViewY, imageView.frame.size.width, imageView.frame.size.height);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.contentView endEditing:YES];
    [self dismiss];
}

#pragma mark - Animations
- (void)configBlurView:(UIView *)parentView{

    if (!_blurView) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.33];
        _blurView = [[FXBlurView alloc] initWithFrame:SCREEN_BOUNDS];
    }
    _blurView.tintColor = [UIColor clearColor];
    _blurView.dynamic = NO;
    _blurView.blurRadius = 0;
    [parentView addSubview:_blurView];
}

#pragma mark - 展示到某个控制器
- (void)present:(UIViewController *)controller{
    UIView *view = controller.view;
    [self setupAlertView];
    if (!_blurEffect) {
        [self coverView];
    } else {
        [self configBlurView:view];
    }
    [view addSubview:self];
    [self displayWithAnimation];
}

- (void)presentOnWindow{
    [self setupAlertView];
    if (!_blurEffect) {
        [self coverView];
    } else {
        [self blurView];
    }

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self displayWithAnimation];
}

- (void)displayWithAnimation{
    if (!_blurEffect) {
        [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.coverView.alpha = 1.0;
                         } completion:nil];
    } else {
        self.blurView.blurRadius = kBlurRadius;
    }

    switch (self.animationStyle) {
        case GRAlertViewAnimationNone:
        {
            // No animation
            break;
        }
        case GRAlertViewAnimationZoomSpring:
        {
            [self.alertView.layer setValue:@(0) forKeyPath:@"transform.scale"];
            [UIView animateWithDuration:0.75
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 [self.alertView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                             } completion:nil];
            break;
        }
        case GRAlertViewAnimationTopToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(self.center.x, -self.alertView.frame.size.height);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
        case GRAlertViewAnimationDownToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(self.center.x, SCREEN_HEIGHT);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
        case GRAlertViewAnimationLeftToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(-kAlertViewW, self.center.y);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
        case GRAlertViewAnimationRightToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(SCREEN_WIDTH + kAlertViewW, self.center.y);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
    }
}

- (void)show {
    if (!_blurEffect) {
        [self coverView];
    } else {
        [self blurView];
    }

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self displayWithAnimation];
}

- (void)dismiss {
    [self.alertView removeFromSuperview];
    if (!_blurEffect) {
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _coverView.alpha = 0;
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    } else {
        [_blurView removeFromSuperview];
        [self removeFromSuperview];
    }
}

#pragma mark - Assist Methods
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Public Methods
- (void)setAnimationStyle:(GRAlertViewAnimationStyle)animationStyle {
    if (_animationStyle == animationStyle) {
        return;
    }
    _animationStyle = animationStyle;
}

- (void)setBlurEffect:(BOOL)blurEffect {
    
    if (_blurEffect == blurEffect) {
        return;
    }
    _blurEffect = blurEffect;
}

@end

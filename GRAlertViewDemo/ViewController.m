//
//  ViewController.m
//  GRAlertViewDemo
//
//  Created by 王虎 on 2017/9/9.
//  Copyright © 2017年 Linyun. All rights reserved.
//

#import "ViewController.h"
#import "DemoTableViewCell.h"

#import "GRAlertView.h"

#import "SexualOrientationContentView.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, MultiSelectViewProtocol>

/** animations */
@property (copy, nonatomic) NSArray<NSString *> *animationTitles;

/** options*/
@property (copy, nonatomic) NSArray<NSNumber *> *animationOptions;

/** alert*/
@property (weak, nonatomic) GRAlertView *alertView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]
                              initWithFrame:self.view.bounds
                              style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[DemoTableViewCell class] forCellReuseIdentifier:[DemoTableViewCell reuseableIdentifier]];

    _animationTitles = [NSArray arrayWithObjects:@"AnimationNon",
                        @"AnimationZoomSpring",
                        @"AnimationTopToCenterSpring",
                        @"AnimationDownToCenterSpring",
                        @"AnimationLeftToCenterSpring",
                        @"AnimationRightToCenterSpring", nil];

    _animationOptions = [NSArray arrayWithObjects:
                         @(GRAlertViewAnimationNone),
                         @(GRAlertViewAnimationZoomSpring),
                         @(GRAlertViewAnimationTopToCenterSpring),
                         @(GRAlertViewAnimationDownToCenterSpring),
                         @(GRAlertViewAnimationLeftToCenterSpring),
                         @(GRAlertViewAnimationRightToCenterSpring), nil];

    self.navigationItem.title = @"AlertView Demo";
}


#pragma mark - tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.animationTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DemoTableViewCell reuseableIdentifier]];
    [cell setText:self.animationTitles[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    GRAlertViewAnimationStyle style = [[self.animationOptions objectAtIndex:indexPath.row] integerValue];
    [self callAlertWithAnimationStyle:style];
}

- (void)callAlertWithAnimationStyle:(GRAlertViewAnimationStyle)style{


    SexualOrientationContentView *contentView = [[SexualOrientationContentView alloc] init];

    GRAlertView *alertView  = [GRAlertView alertViewWithContentView:contentView ViewHeight:408 ViewWidth:284];
    contentView.delegate = self;
    alertView.topImageName = @"illustrationBalloon";
    alertView.animationStyle = style;
    _alertView = alertView;
    [alertView present:self.navigationController];

    //[alertView presentOnWindow];
}

#pragma mark - delegate Method
- (void)cancelButtonClicked{
    [self.alertView  dismiss];
}

- (void)commitComments:(NSDictionary<NSString *,NSString *> *)comments{
    NSLog(@"----%@", comments);
}


@end

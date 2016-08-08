//
//  ActivityView.m
//  Your Player
//
//  Created by viera on 7/10/16.
//  Copyright © 2016 vydeveloping. All rights reserved.
//

#import "ActivityView.h"
#import "DGActivityIndicatorView.h"

@interface ActivityView()

@property (nonatomic, strong) DGActivityIndicatorView *activity;

@end

@implementation ActivityView

#pragma mark - Memory management

+ (ActivityView*)instance
{
    static dispatch_once_t pred;
    static ActivityView *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[ActivityView alloc] init];
    });
    return shared;
}

#pragma mark - View LifeCycle

#pragma mark - Action Handlers

#pragma mark - Public

- (void)showInView:(UIView*)view
{
    if (self.superview) [self hide];
    self.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
    self.activity = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallPulse tintColor: [UIColor colorWithRed:191.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f]];
    self.activity.frame = CGRectMake(0, 0, 20, 20);
    self.activity.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:self.activity];
    [view addSubview:self];
    [self.activity startAnimating];
}

- (void)hide
{
    [self.activity stopAnimating];
    [self.activity removeFromSuperview];
    [self removeFromSuperview];
}

#pragma mark - Private

#pragma mark - Delegates

@end

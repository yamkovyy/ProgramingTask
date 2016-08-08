//
//  UIViewController+BackgroundWithGradient.m
//  DiscountBank
//
//  Created by viera on 11/23/15.
//  Copyright © 2015 viera. All rights reserved.
//

#import "UIViewController+BackgroundWithGradient.h"

@implementation UIViewController (BackgroundWithGradient)

- (void)prepareBackgroundColor {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor purpleColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

@end

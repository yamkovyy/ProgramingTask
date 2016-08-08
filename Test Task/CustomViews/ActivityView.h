//
//  ActivityView.h
//  Your Player
//
//  Created by viera on 7/10/16.
//  Copyright © 2016 vydeveloping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityView : UIView

+ (ActivityView*)instance;
- (void)showInView:(UIView*)view;
- (void)hide;

@end

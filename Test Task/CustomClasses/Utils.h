//
//  Utils.h
//  TestCase
//
//  Created by viera on 8/3/16.
//  Copyright © 2016 vydeveloping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (void)showAlertIn:(UIViewController*)viewController withTitle:(NSString*)title message:(NSString*)message withDuration:(float)duration;
+ (BOOL)isOnline;

@end

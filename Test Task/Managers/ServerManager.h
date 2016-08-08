//
//  ServerManager.h
//  Test Task
//
//  Created by viera on 8/8/16.
//  Copyright © 2016 vydeveloping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ServerManager : NSObject

+ (ServerManager*)sharedManager;

-(void)loginUser: (NSString*)username withPassword: (NSString*)password completetionBlock: (void (^)(BOOL success, NSArray *availableGameWorlds, NSError *error))completionBlock;

@end

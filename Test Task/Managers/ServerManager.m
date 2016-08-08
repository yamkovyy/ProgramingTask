//
//  ServerManager.m
//  Test Task
//
//  Created by viera on 8/8/16.
//  Copyright © 2016 vydeveloping. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"
#import "Utils.h"

#define kBaseMethodURL @"http://backend1.lordsandknights.com"

@interface ServerManager()

@property (nonatomic, strong) AFHTTPRequestOperationManager *mHttpManager;

@end

@implementation ServerManager

#pragma mark - Memory management
+ (ServerManager*)sharedManager
{
    static dispatch_once_t pred;
    static ServerManager *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[ServerManager alloc] init];
        [shared initHTTPManager];
    });
    
    return shared;
}

#pragma mark - View LifeCycle

#pragma mark - Action Handlers

#pragma mark - Public
-(void)loginUser: (NSString*)username withPassword: (NSString*)password completetionBlock: (void (^)(BOOL success, NSArray *availableGameWorlds, NSError *error))completionBlock
{
    if ([Utils isOnline])
    {
        NSString *deviceType = [self getDeviceType];
        NSString *deviceId = [[NSUUID UUID] UUIDString];
        
        NSDictionary *params = @{@"login" : username, @"password" : password, @"deviceType" : deviceType, @"deviceId" : deviceId};
        
        [self.mHttpManager POST:@"/XYRALITY/WebObjects/BKLoginServer.woa/wa/worlds" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSArray *responseList = operation.responseObject[@"allAvailableWorlds"];
             if (responseList)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     completionBlock(YES, responseList, nil);
                 });
             }
             else
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     completionBlock(NO, nil, nil);
                 });
             }
         }
                        failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 completionBlock(NO, nil, error);
             });
         }];

    }
    else
    {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: @"No Internet connection.",
                                   NSLocalizedFailureReasonErrorKey: @"No Internet connection.",
                                   NSLocalizedRecoverySuggestionErrorKey: @"Please make sure that you have internet connection?"
                                   };
        NSError *error = [NSError errorWithDomain: kBaseMethodURL
                                             code:-57
                                         userInfo:userInfo];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(NO, nil, error);
        });
    }

}

#pragma mark - Private
- (void)initHTTPManager
{
    self.mHttpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString: kBaseMethodURL]];
    [self.mHttpManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    self.mHttpManager.responseSerializer = [AFPropertyListResponseSerializer serializer];
    self.mHttpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"application/x-plist"];
}

- (NSString*)getDeviceType
{
    return [NSString stringWithFormat:@"%@ - %@ %@", [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
}

#pragma mark - Delegates




@end

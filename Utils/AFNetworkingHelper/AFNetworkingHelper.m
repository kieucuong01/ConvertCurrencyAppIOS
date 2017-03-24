//
//  AFNetworkingHelper.m
//  OrderProcessing
//
//  Created by Khang Nguyen on 8/3/16.
//  Copyright © 2016 Huy Le. All rights reserved.
//

#import "AFNetworkingHelper.h"
#import "URLManager.h"

@implementation AFNetworkingHelper

+ (AFNetworkingHelper *)sharedClient {
    static AFNetworkingHelper *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        //session config
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
       
        _sharedClient = [[self alloc] initWithSessionConfiguration:sessionConfiguration];
    });
    _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
    return _sharedClient;
}


-(void)internalRequestWithDict:(NSDictionary*)dict isPostMethod:(BOOL)isPost path:(NSString*)strPath isJSONResponse:(BOOL)isJSON useToken:(BOOL)useToken successBlock:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
            [self privateRequestMessage:dict isPostMethod:isPost path:strPath isJSONResponse:isJSON useToken:useToken successBlock:success failure:failure];

}

-(void)privateRequestMessage:(NSDictionary*)dict isPostMethod:(BOOL)isPost path:(NSString*)strPath isJSONResponse:(BOOL)isJSON useToken:(BOOL)useToken successBlock:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSString* token = @"";
    //Request
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (useToken==YES) {
        [self.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    }
    if (isJSON==YES) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    else
    {
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
 
    
    if (isPost==YES) {
        [self POST:strPath parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success(task,responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
//                [[[gdrUtils sharedUtils] getAppDelegate] checkInternetConnection];
                failure(task,error);
            }
        }];
    }
    else
    {
        [self GET:strPath parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success(task,responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(task,error);
            }
        }];
    }
}

-(void)getListCurrency:(NSString*)param SuccessBlock:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    [self internalRequestWithDict:nil isPostMethod:NO path:[[URLManager getListCurrencyURLString] stringByAppendingString:param] isJSONResponse:YES useToken:YES successBlock:success failure:failure];
}

@end

//
//  AFNetworkingHelper.h
//  OrderProcessing
//
//  Created by Khang Nguyen on 8/3/16.
//  Copyright © 2016 Huy Le. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import "URLManager.h"

@interface AFNetworkingHelper : AFHTTPSessionManager

+ (AFNetworkingHelper *)sharedClient;

-(void)getListCurrency:(NSString*)param SuccessBlock:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end

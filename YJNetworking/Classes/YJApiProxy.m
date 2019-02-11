//
//  YJApiProxy.m
//  YJNetworking_Example
//
//  Created by yj on 2019/2/11.
//  Copyright © 2019年 full-of-fire. All rights reserved.
//

#import "YJApiProxy.h"
#import <AFNetworking/AFNetworking.h>

@interface YJApiProxy()
@property (strong,nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong,nonatomic) NSMutableDictionary *dispathTable;
@end


@implementation YJApiProxy
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


+ (instancetype)shareInstance{
    
    static YJApiProxy *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 60;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        _dispathTable = [NSMutableDictionary dictionary];
    }
    return self;
}


- (NSNumber*)GET:(NSString*)path parameters:(NSDictionary*)parameters success:(void(^)(id result))success fail:(void(^)(NSError *error))fail{
    if (![self p_checkReachable]) {
        if ([self.delegate respondsToSelector:@selector(hanlderNoNetwork:)]) {
            [self.delegate hanlderNoNetwork:self];
        }
        if (fail) {
            fail([NSError errorWithDomain:@"网络无连接" code:-1 userInfo:nil]);
        }
        return @(-1);
    }
    
    //如果需要配置全局参数就配置全局参数
    NSDictionary *result = [self p_converGlobalParams:parameters];
    NSURLSessionDataTask * dataTask = [self.sessionManager GET:path parameters:result progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self p_handleGlobalResponse:responseObject];
        success?success(responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self p_handlerSessionError:error];
        fail?fail(error):nil;
    }];
    
    NSUInteger takskId = [dataTask taskIdentifier];
    self.dispathTable[@(takskId)] = dataTask;
    return @(takskId);
}



- (NSNumber*)POST:(NSString*)path parameters:(NSDictionary*)parameters success:(void(^)(id result))success fail:(void(^)(NSError *error))fail{
    if (![self p_checkReachable]) {
        if ([self.delegate respondsToSelector:@selector(hanlderNoNetwork:)]) {
            [self.delegate hanlderNoNetwork:self];
        }
        if (fail) {
            fail([NSError errorWithDomain:@"网络无连接" code:-1 userInfo:nil]);
        }
        return @(-1);
    }
    
    //如果需要配置全局参数就配置全局参数
    NSDictionary *result = [self p_converGlobalParams:parameters];
    NSURLSessionDataTask * dataTask = [self.sessionManager POST:path parameters:result progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self p_handleGlobalResponse:responseObject];
        success?success(responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self p_handlerSessionError:error];
        fail?fail(error):nil;
    }];
    
    NSUInteger takskId = [dataTask taskIdentifier];
    self.dispathTable[@(takskId)] = dataTask;
    return @(takskId);
}


- (NSNumber*)POSTForm:(NSString*)path parameters:(NSDictionary*)parameters success:(void(^)(id result))success fail:(void(^)(NSError *error))fail{
    if (![self p_checkReachable]) {
        if ([self.delegate respondsToSelector:@selector(hanlderNoNetwork:)]) {
            [self.delegate hanlderNoNetwork:self];
        }
        if (fail) {
            fail([NSError errorWithDomain:@"网络无连接" code:-1 userInfo:nil]);
        }
        return @(-1);
    }
    
    //如果需要配置全局参数就配置全局参数
    NSDictionary *result = [self p_converGlobalParams:parameters];
    NSURLSessionDataTask * dataTask = [self.sessionManager POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSString *key in result.allKeys) {
            id value = result[key];
            if ([value isKindOfClass:[NSString class]]) {
                [formData appendPartWithFormData:[value dataUsingEncoding:NSUTF8StringEncoding] name:key];
            }else if([value isKindOfClass:[NSNumber class]]){
                [formData appendPartWithFormData:[[value stringValue] dataUsingEncoding:NSUTF8StringEncoding] name:key];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self p_handleGlobalResponse:responseObject];
        success?success(responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self p_handlerSessionError:error];
        fail?fail(error):nil;
    }];
    
    NSUInteger takskId = [dataTask taskIdentifier];
    self.dispathTable[@(takskId)] = dataTask;
    return @(takskId);
}


- (NSNumber*)FileUpload:(NSString*)path parameters:(NSDictionary*)parameters data:(id)data fileName:(NSString*)fileName name:(NSString*)name success:(void(^)(id result))success fail:(void(^)(NSError *error))fail{
    if (![self p_checkReachable]) {
        if ([self.delegate respondsToSelector:@selector(hanlderNoNetwork:)]) {
            [self.delegate hanlderNoNetwork:self];
        }
        if (fail) {
            fail([NSError errorWithDomain:@"网络无连接" code:-1 userInfo:nil]);
        }
        return @(-1);
    }
    
    //如果需要配置全局参数就配置全局参数
    NSDictionary *result = [self p_converGlobalParams:parameters];
    NSURLSessionDataTask * dataTask = [self.sessionManager POST:path parameters:result constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if ([data isKindOfClass:[NSData class]]) {
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"multipart/form-data"];
        }else if([data isKindOfClass:[NSURL class]]){
            [formData appendPartWithFileURL:data name:name error:nil];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self p_handleGlobalResponse:responseObject];
        success?success(responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self p_handlerSessionError:error];
        fail?fail(error):nil;
    }];
    
    NSUInteger takskId = [dataTask taskIdentifier];
    self.dispathTable[@(takskId)] = dataTask;
    return @(takskId);
}


- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *requestOperation = self.dispathTable[requestID];
    [requestOperation cancel];
    [self.dispathTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}



#pragma mark - private
- (BOOL)p_checkReachable{
    BOOL isReachable =  [[AFNetworkReachabilityManager sharedManager] isReachable];
    return isReachable;
}

- (NSDictionary*)p_converGlobalParams:(NSDictionary*)params {
    if (!params) {
        return nil;
    }
    
    NSMutableDictionary *result = [params mutableCopy];
    if ([self.dataSource respondsToSelector:@selector(globalParamsForApiProxy:)]) {
        NSDictionary *globalPrams = [self.dataSource globalParamsForApiProxy:self];
        if (globalPrams) {
            for (NSString *key  in globalPrams.allKeys) {
                result[key] = globalPrams[key];
            }
        }
    }
    return result.copy;
}


- (void)p_handlerSessionError:(NSError*)error{
    if (error.userInfo[@"com.alamofire.serialization.response.error.response"]) {
        NSHTTPURLResponse *response = error.userInfo[@"com.alamofire.serialization.response.error.response"];
        NSUInteger statusCode = response.statusCode;
        NSString *errorMsg =  [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode];
        
        if ([self.delegate respondsToSelector:@selector(hanlderError: errorMsg: errorCode: apiPxoxy:)]) {
            [self.delegate hanlderError:error errorMsg:errorMsg errorCode:statusCode apiPxoxy:self];
        }
        
    }
}

- (void)p_handleGlobalResponse:(id)response{
    if ([self.delegate respondsToSelector:@selector(hanlderResponse:apiPxoxy:)]) {
        [self.delegate hanlderResponse:response apiPxoxy:self];
    }
}




@end

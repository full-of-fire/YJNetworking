//
//  YJApiProxy.h
//  YJNetworking_Example
//
//  Created by yj on 2019/2/11.
//  Copyright © 2019年 full-of-fire. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJApiProxy;
@protocol YJApiProxyDelegate<NSObject>
@optional

/**
 无网络处理

 @param apiProxy 网络请求单例
 */
- (void)hanlderNoNetwork:(YJApiProxy*)apiProxy;



/**
 全局网络请求错误的处理

 @param error 错误
 @param errorMsg 常见的错误中文 如400，401，403，500等
 @param errorCode 错误码
 @param apiProxy 网络请求单例
 */
- (void)hanlderError:(NSError*)error errorMsg:(NSString*)errorMsg errorCode:(NSUInteger)errorCode apiPxoxy:(YJApiProxy*)apiProxy;


/**
 统一处理返回结果，如登录超时，需要全局跳转到登录界面。

 @param response 请求返回结果
 @param apiProxy  网络请求单例
 */
- (void)hanlderResponse:(id)response apiPxoxy:(YJApiProxy*)apiProxy;

@end

@protocol  YJApiProxyDataSource<NSObject>
@optional
/**
 配置通用参数，比如登录后需要配置统一的token参数
 
 @param apiProxy 网络请求单例
 @return 通用参数
 */
- (NSDictionary*)globalParamsForApiProxy:(YJApiProxy*)apiProxy;
@end

@interface YJApiProxy : NSObject
@property (weak,nonatomic) id<YJApiProxyDelegate> delegate;
@property (weak,nonatomic) id<YJApiProxyDataSource> dataSource;


- (NSNumber*)GET:(NSString*)path parameters:(NSDictionary*)parameters success:(void(^)(id result))success fail:(void(^)(NSError *error))fail;
- (NSNumber*)POST:(NSString*)path parameters:(NSDictionary*)parameters success:(void(^)(id result))success fail:(void(^)(NSError *error))fail;
- (NSNumber*)POSTForm:(NSString*)path parameters:(NSDictionary*)parameters success:(void(^)(id result))success fail:(void(^)(NSError *error))fail;
- (NSNumber*)FileUpload:(NSString*)path parameters:(NSDictionary*)parameters data:(id)data fileName:(NSString*)fileName name:(NSString*)name success:(void(^)(id result))success fail:(void(^)(NSError *error))fail;
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;
+ (instancetype)shareInstance;
@end

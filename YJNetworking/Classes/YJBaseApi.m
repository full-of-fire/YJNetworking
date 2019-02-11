//
//  YJBaseApi.m
//  YJNetworking_Example
//
//  Created by yj on 2019/2/11.
//  Copyright © 2019年 full-of-fire. All rights reserved.
//

#import "YJBaseApi.h"
#import "YJApiProxy.h"
#import <MJExtension/MJExtension.h>

NSString * const kApiMethodGet = @"GET";
NSString * const kApiMethodPost = @"POST";
NSString * const kApiMethodPostForm = @"POSTFrom";
NSString * const kApiMethodFileUpload = @"FileUpload";
@interface YJBaseApi()
@property (strong,nonatomic) NSNumber *taskId;
@end
@implementation YJBaseApi

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(YJBaseApiDelegate)]) {
            self.child = (id <YJBaseApiDelegate>)self;
        } else {
            self.child = (id <YJBaseApiDelegate>)self;
            NSException *exception = [[NSException alloc] initWithName:@"YJBaseApi提示" reason:[NSString stringWithFormat:@"%@没有遵循YJBaseApiDelegate协议",self.child] userInfo:nil];
            @throw exception;
        }
    }
    return self;
}


- (void)loadDataSuccess:(void (^)(id))success fail:(void (^)(NSError *))fail{
    NSMutableDictionary *params = [self mj_keyValues];
    [params removeObjectForKey:@"child"];
    [params removeObjectForKey:@"debugDescription"];
    [params removeObjectForKey:@"description"];
    [params removeObjectForKey:@"hash"];
    [params removeObjectForKey:@"superclass"];
    
    [self loadDataWithParams:params success:success fail:fail];
}
- (void)loadDataWithParams:(NSDictionary *)parmas success:(void (^)(id))success fail:(void (^)(NSError *))fail{
    NSString *path = [self.child path];
    NSString *method = [self.child method];
    
    if ([method isEqualToString:kApiMethodGet]) {
        [[YJApiProxy shareInstance] GET:path parameters:parmas success:success fail:fail];
    }else if ([method isEqualToString:kApiMethodPost]){
        [[YJApiProxy shareInstance] POST:path parameters:parmas success:success fail:fail];
    }else if ([method isEqualToString:kApiMethodFileUpload]){
        [[YJApiProxy shareInstance] FileUpload:path parameters:parmas data:[self.child fileData] fileName:[self.child fileName] name:[self.child name] success:success fail:fail];
    }else if ([method isEqualToString:kApiMethodPostForm]){
        [[YJApiProxy shareInstance] POSTForm:path parameters:parmas success:success fail:fail];
    }
}


- (void)dealloc
{
    [[YJApiProxy shareInstance] cancelRequestWithRequestID:self.taskId];
}

@end

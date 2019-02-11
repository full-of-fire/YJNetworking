//
//  YJViewController.m
//  YJNetworking
//
//  Created by full-of-fire on 02/11/2019.
//  Copyright (c) 2019 full-of-fire. All rights reserved.
//

#import "YJViewController.h"
#import <YJNetworking/YJNetworking.h>
#import "YJSendSmsApi.h"
@interface YJViewController ()<YJApiProxyDelegate,YJApiProxyDataSource>
@property (strong,nonatomic) YJSendSmsApi *smsApi;
@end

@implementation YJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [YJApiProxy shareInstance].delegate = self;
    [YJApiProxy shareInstance].dataSource = self;
    
    _smsApi = [[YJSendSmsApi alloc] init];
    _smsApi.phone = @"17773903585";
    _smsApi.type = @"1";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_smsApi loadDataSuccess:^(id result) {
        
    } fail:^(NSError *error) {
        
    }];
}



/**
 无网络处理
 
 @param apiProxy 网络请求单例
 */
- (void)hanlderNoNetwork:(YJApiProxy*)apiProxy {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前无网络连接" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alertView show];
}



/**
 全局网络请求错误的处理
 
 @param error 错误
 @param errorMsg 常见的错误中文 如400，401，403，500等
 @param errorCode 错误码
 @param apiProxy 网络请求单例
 */
- (void)hanlderError:(NSError*)error errorMsg:(NSString*)errorMsg errorCode:(NSUInteger)errorCode apiPxoxy:(YJApiProxy*)apiProxy {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMsg delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alertView show];
}

// 全局处理
- (void)hanlderResponse:(id)response apiPxoxy:(YJApiProxy *)apiProxy{
    
    if ([response[@"code"] intValue] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发送成功" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:response[@"msg"] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

/**
 配置通用参数，比如登录后需要配置统一的token参数
 
 @param apiProxy 网络请求单例
 @return 通用参数
 */
- (NSDictionary*)globalParamsForApiProxy:(YJApiProxy*)apiProxy {
    
    return nil;
}


@end

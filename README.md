# YJNetworking

[![CI Status](https://img.shields.io/travis/full-of-fire/YJNetworking.svg?style=flat)](https://travis-ci.org/full-of-fire/YJNetworking)
[![Version](https://img.shields.io/cocoapods/v/YJNetworking.svg?style=flat)](https://cocoapods.org/pods/YJNetworking)
[![License](https://img.shields.io/cocoapods/l/YJNetworking.svg?style=flat)](https://cocoapods.org/pods/YJNetworking)
[![Platform](https://img.shields.io/cocoapods/p/YJNetworking.svg?style=flat)](https://cocoapods.org/pods/YJNetworking)

## Example
1、首先继承`YJBaseApi`,遵守`YJBaseApiDelegate`
```
@interface YJSendSmsApi : YJBaseApi<YJBaseApiDelegate>
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *type;
```
2、实现`YJBaseApiDelegate`协议
```
- (NSString*)path{
    return @"http://www.maijiaxiu365.com/buyershow-api/api/businessUser/send/sms";
}
- (NSString*)method{
    return kApiMethodPostForm;
}
```
mehod方法的可选值有`GET`,`POST`,'FileUpload','POSTForm'
path 方法返回的是请求的路径
3、配置网络请求的全局处理方式
```
    [YJApiProxy shareInstance].delegate = self;
    [YJApiProxy shareInstance].dataSource = self;
    @interface YJViewController ()<YJApiProxyDelegate,YJApiProxyDataSource>
    
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
```
4、调用
```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _smsApi = [[YJSendSmsApi alloc] init];
    _smsApi.phone = @"17773903585";
    _smsApi.type = @"1";
    [_smsApi loadDataSuccess:^(id result) {
        
    } fail:^(NSError *error) {
        
    }];
}
```

## Requirements

## Installation

YJNetworking is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YJNetwork'
```

## Author

full-of-fire, 591730822@qq.com

## License

YJNetworking is available under the MIT license. See the LICENSE file for more info.

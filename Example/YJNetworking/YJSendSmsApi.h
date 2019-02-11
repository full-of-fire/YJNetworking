//
//  YJSendSmsApi.h
//  YJNetworking_Example
//
//  Created by yj on 2019/2/11.
//  Copyright © 2019年 full-of-fire. All rights reserved.
//

#import <YJNetworking/YJNetworking.h>

@interface YJSendSmsApi : YJBaseApi<YJBaseApiDelegate>
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *type;

@end

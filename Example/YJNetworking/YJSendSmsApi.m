//
//  YJSendSmsApi.m
//  YJNetworking_Example
//
//  Created by yj on 2019/2/11.
//  Copyright © 2019年 full-of-fire. All rights reserved.
//

#import "YJSendSmsApi.h"

@implementation YJSendSmsApi
- (NSString*)path{
    return @"http://www.maijiaxiu365.com/buyershow-api/api/businessUser/send/sms";
}
- (NSString*)method{
    return kApiMethodPostForm;
}
@end

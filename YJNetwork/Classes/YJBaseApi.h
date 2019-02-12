//
//  YJBaseApi.h
//  YJNetworking_Example
//
//  Created by yj on 2019/2/11.
//  Copyright © 2019年 full-of-fire. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kApiMethodGet;
extern NSString * const kApiMethodPost;
extern NSString * const kApiMethodPostForm;
extern NSString * const kApiMethodFileUpload;

/*
 YJBaseApi的子类生类必须符合这些protocal
 */
@protocol YJBaseApiDelegate<NSObject>
@required
- (NSString*)path;

/**
 请求方法，POST，GET，FileUpload

 @return 请求方法
 */
- (NSString*)method;
@optional

/**
 文件数据

 @return 文件数据
 */
- (NSData*)fileData;

/**
 完整文件名

 @return 文件名
 */
- (NSString*)fileName;

/**
 文件key

 @return key
 */
- (NSString*)name;
@end

@interface YJBaseApi : NSObject
@property (nonatomic, weak) id<YJBaseApiDelegate> child; //里面会调用到NSObject的方法，所以这里不用id
- (void)loadDataSuccess:(void(^)(id result))success fail:(void(^)(NSError *error))fail;
- (void)loadDataWithParams:(NSDictionary*)parmas success:(void(^)(id result))success fail:(void(^)(NSError *error))fail;
@end

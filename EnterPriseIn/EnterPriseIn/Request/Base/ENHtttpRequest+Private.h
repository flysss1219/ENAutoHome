//
//  ENHtttpRequest+Private.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/7.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENHtttpRequest.h"

@interface ENHtttpRequest (Private)

NSString *HTTPRequestPrivateBaseURL();

typedef void(^HTTPRequestResponseBlock)(NSUInteger code,
                                        NSString *message,
                                        id data);
//post
+ (void)postCommand:(NSString *)command
                url:(NSString *)url
         parameters:(NSDictionary *)parameters
      responseBlock:(HTTPRequestResponseBlock)responseBlock;


+ (void)postCommand:(NSString *)command
                url:(NSString *)url
         parameters:(NSDictionary *)parameters
            timeout:(NSTimeInterval)timeout
      responseBlock:(HTTPRequestResponseBlock)responseBlock;

//get
+ (void)getCommand:(NSString *)command
                url:(NSString *)url
         parameters:(NSDictionary *)parameters
      responseBlock:(HTTPRequestResponseBlock)responseBlock;


+ (void)getCommand:(NSString *)command
                url:(NSString *)url
         parameters:(NSDictionary *)parameters
            timeout:(NSTimeInterval)timeout
      responseBlock:(HTTPRequestResponseBlock)responseBlock;

+ (void)uploadImageWithImage:(UIImage *)image
             responseBlock:(HTTPRequestResponseBlock)responseBlock;


@end

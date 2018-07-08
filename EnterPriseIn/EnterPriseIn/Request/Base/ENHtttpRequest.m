//
//  ENHtttpRequest.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/7.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENHtttpRequest.h"
#import "ENHtttpRequest+Private.h"
#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"
#import "AppDelegate.h"
#import "NSDictionary+Null.h"
#import "NSArray+Null.h"
#import "NSArray+StringValue.h"
#import "NSDictionary+StringValue.h"
#import "CryptFunction.h"
#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager+Shun.h"
#import "cJSON.h"
#import "NSData+Base64.h"
#import "JSONKit.h"

#define desKey @"newland_Iportol@lx100$#3"

NSInteger const HTTPPageSize = 20;

static NSString * const kBaseURL  = @"/api/home/index";    // 公网服务器

@implementation ENHtttpRequest

#pragma mark - Private functions

static NSString* JSONStringFromDictionary(NSDictionary *dictionary) {
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    return JSONStringFromData(data);
}

NSString *AppRequestManagerDefaultHTTPContentType() {
    return @"text/plain;charset=utf-8";
}

static NSString* JSONStringFromData(NSData *data) {
    
    cJSON *json = cJSON_Parse(data.bytes);
    if (!json) {
        NSLog(@"parse parameter JSON string failed! response is: %s", data.bytes);
        return @"";
    }
    
    char *cstring = cJSON_Print(json);
    NSString *jsonString = [NSString stringWithCString:cstring encoding:NSUTF8StringEncoding];
    free(cstring);
    cJSON_Delete(json);
    
    return jsonString;
}

#pragma mark - Public functions

NSString* HTTPRequestPrivateBaseURL() {
    return [NSString stringWithFormat:@"%@",kBaseURL];
}

#pragma mark - Private methods

+ (void)startRequestCommand:(NSString *)command
                        url:(NSString *)url
                     method:(NSString *)method
                 parameters:(NSDictionary *)parameters
                    timeout:(NSTimeInterval)timeout
              responseBlock:(HTTPRequestResponseBlock)responseBlock {

    url = [NSString stringWithFormat:@"%@%@",kBasePort,url];
    NSData *bodyData;
    if(parameters != nil){
        bodyData = [NSJSONSerialization dataWithJSONObject:parameters
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
        // 构造请求参数
        NSLog(@"%@ ----- url is: %@, request parameters are: %@", command, url, JSONStringFromDictionary(parameters));
//        bodyData = [CryptFunction TripleDESEncrypt:bodyData WithKey:desKey];
         url = [NSString stringWithFormat:@"%@?%@",url,bodyData];
    }
   
//    NSString *nonce = [GlobalFunction generateUUID];
//    NSString *timestamp = [NSString stringWithFormat:@"%llu", (long long)[NSDate date].timeIntervalSince1970];
//
//    NSString *encripStr = [NSString stringWithFormat:@"%@&%@", nonce, timestamp];
//    NSString *signature = [CryptFunction hmacsha1:encripStr secret:@"shiyanshi2015"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = timeout;
    
//    [manager.requestSerializer setValue:@"zuolinyouli" forHTTPHeaderField:@"consumerKey"];
//    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"nonce"];
//    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"timestamp"];
//    [manager.requestSerializer setValue:signature forHTTPHeaderField:@"signature"];
    
//    [manager.requestSerializer setValue:[CurrentUser sharedInstance].user_app_secretkey forHTTPHeaderField:@"secretkey"];
//    [manager.requestSerializer setValue:[CurrentCityManager currentCity].cityid forHTTPHeaderField:@"cityid"];
//    [manager.requestSerializer setValue:[CurrentUser sharedInstance].tokenKey forHTTPHeaderField:@"token"];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"application/octet-stream",@"multipart/form-data" , nil];
    
//    [manager.requestSerializer setValue:[[CurrentUser sharedInstance] userAgent] forHTTPHeaderField:@"User-Agent"];
    
    [manager GET:url httpBody:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
        
//        response = [CryptFunction TripleDESDecrypt:response WithKey:desKey];
        
        NSLog(@"%@ url --%@ response JSON is: %@ ", NSStringFromClass(self.class),url,JSONStringFromData(response));
        
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:response
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:NULL];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            responseObject = [responseObject dictionaryWithoutNull];
            responseObject = [responseObject dictionaryWithStringValue];
            
            NSString *message = responseObject[@"tips"];
            NSNumber *code = responseObject[@"status"];
            NSDictionary *data = responseObject[@"data"];
            /*
             接口返回参数统一规范：
             1.    所有情况，接口都统一返回包括status,tips,data三种属性的json数据。status表示状态，tips表示提示语，data表示返回所需数据；
             2.    status状态枚举值有且只有以下四个：1正常情况，2入参报错，3接口处理报错，4token问题。其中，数据为空时，属于正常情况（即status=1）；
             3.    正常情况下（status=1），返回的data数据必须保持一致，即data中某个字段的属性定义成对象，就必须是对象，无论该属性是否获取到数据；
             4.    非正常情况下（status!=1），data返回的数据一律为空字符串。（zqq 接口不给1直接设data为nil）
             */
            
            if (responseBlock) {
                
                if ([code integerValue] != 1) {
                    responseBlock([code integerValue], message, nil);
                }else{
                    responseBlock([code integerValue], message, data);
                }
            }
        }else {
            if (responseBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    responseBlock(-1, @"当前网络状况不佳", nil);
                });
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@ request failed, error is: %@", command, error);
        
        if (responseBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                responseBlock(error.code, @"当前网络状况不佳", nil);
            });
        }
    }];
}

+ (void)startImageRequestCommand:(NSString *)command
                             url:(NSString *)url
                          method:(NSString *)method
                           image:(UIImage *)image
                      parameters:(NSDictionary *)parameters
                         timeout:(NSTimeInterval)timeout
                   responseBlock:(HTTPRequestResponseBlock)responseBlock {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = timeout;
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = [GlobalFunction zipNSDataWithImage:image];
        
        if (UIImagePNGRepresentation(image)) {
            if (imageData !=nil) {
                [formData appendPartWithFileData:imageData name:@"1" fileName:@"ios.png" mimeType:@"image/png"];
            }
        }else{
            if (imageData != nil) {
                [formData appendPartWithFileData:imageData name:@"1" fileName:@"ios.jpg" mimeType:@"image/jpeg"];
            }
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:response
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:NULL];
        NSLog(@"%@ url --%@ response JSON is: %@ ", NSStringFromClass(self.class),url,JSONStringFromData(response));
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            responseObject = [responseObject dictionaryWithoutNull];
            responseObject = [responseObject dictionaryWithStringValue];
            
            NSString *message = responseObject[@"tips"];
            NSNumber *code = responseObject[@"status"];
            NSDictionary *data = responseObject[@"data"];
            
            if (responseBlock) {
                
                if ([code integerValue] != 1) {
                    responseBlock([code integerValue], message, nil);
                }else{
                    responseBlock([code integerValue], message, data);
                }
                
            }
        }else {
            if (responseBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    responseBlock(-1, @"当前网络状况不佳", nil);
                });
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@ request failed, error is: %@", command, error);
        
        if (responseBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                responseBlock(error.code, @"", nil);
            });
        }
    }];
    
}


#pragma mark - Public methods

+ (void)postCommand:(NSString *)command
                url:(NSString *)url
         parameters:(NSDictionary *)parameters
      responseBlock:(HTTPRequestResponseBlock)responseBlock {
    return [self postCommand:command url:url parameters:parameters timeout:60 responseBlock:responseBlock];
}

+ (void)postCommand:(NSString *)command
                url:(NSString *)url
         parameters:(NSDictionary *)parameters
            timeout:(NSTimeInterval)timeout
      responseBlock:(HTTPRequestResponseBlock)responseBlock {
    
    [self startRequestCommand:command
                          url:url
                       method:@"POST"
                   parameters:parameters
                      timeout:timeout
                responseBlock:responseBlock];
}


//get
+ (void)getCommand:(NSString *)command
               url:(NSString *)url
        parameters:(NSDictionary *)parameters
     responseBlock:(HTTPRequestResponseBlock)responseBlock{
     return [self getCommand:command url:url parameters:parameters timeout:60 responseBlock:responseBlock];
}


+ (void)getCommand:(NSString *)command
               url:(NSString *)url
        parameters:(NSDictionary *)parameters
           timeout:(NSTimeInterval)timeout
     responseBlock:(HTTPRequestResponseBlock)responseBlock{
    [self startRequestCommand:command
                          url:url
                       method:@"GET"
                   parameters:parameters
                      timeout:timeout
                responseBlock:responseBlock];
}



+ (void)uploadImageWithImage:(UIImage *)image
             responseBlock:(HTTPRequestResponseBlock)responseBlock {
    
    [self startImageRequestCommand:NSStringFromSelector(_cmd)
                               url:@"http://imgapi.berui.com/one/upload.php?app=hfEsf&isPhone=1"
                            method:@"POST"
                             image:(UIImage *)image
                        parameters:nil
                           timeout:60
                     responseBlock:responseBlock];
}



@end

/*****************************************************************************
 文件名称 :
 版权声明 : Copyright (C), 2010-2013 Easier Digital Tech. Co., Ltd.
 文件描述 : 全局函数
 ******************************************************************************/

#import "sys/sysctl.h"
#import "GlobalFunction.h"
#import "UIAlertView+Blocks.h"
#import "zlib.h"

#import "AppDelegate.h"
#import "UIColor+Hex.h"
#import "UIView+Toast.h"

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
#define fileManager [NSFileManager defaultManager]

#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

@implementation GlobalFunction

+ (NSData*)compressData:(NSData*)uncompressedData {
    
    NSParameterAssert(uncompressedData);
    NSParameterAssert(uncompressedData.length);
    
    z_stream zlibStreamStruct;
    zlibStreamStruct.zalloc    = Z_NULL; // Set zalloc, zfree, and opaque to Z_NULL so
    zlibStreamStruct.zfree     = Z_NULL; // that when we call deflateInit2 they will be
    zlibStreamStruct.opaque    = Z_NULL; // updated to use default allocation functions.
    zlibStreamStruct.total_out = 0; // Total number of output bytes produced so far
    zlibStreamStruct.next_in   = (Bytef*)[uncompressedData bytes]; // Pointer to input bytes
    zlibStreamStruct.avail_in  = (uInt)[uncompressedData length]; // Number of input bytes left to process
    
    int initError = deflateInit2(&zlibStreamStruct, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY);
    if (initError != Z_OK) {
        NSString *errorMsg = nil;
        switch (initError)
        {
            case Z_STREAM_ERROR:
                errorMsg = @"Invalid parameter passed in to function.";
                break;
            case Z_MEM_ERROR:
                errorMsg = @"Insufficient memory.";
                break;
            case Z_VERSION_ERROR:
                errorMsg = @"The version of zlib.h and the version of the library linked do not match.";
                break;
            default:
                errorMsg = @"Unknown error code.";
                break;
        }
        NSLog(@"%s: deflateInit2() Error: \"%@\" Message: \"%s\"", __func__, errorMsg, zlibStreamStruct.msg);
        return nil;
    }
    // Create output memory buffer for compressed data. The zlib documentation states that
    // destination buffer size must be at least 0.1% larger than avail_in plus 12 bytes.
    NSMutableData *compressedData = [NSMutableData dataWithLength:[uncompressedData length] * 1.01 + 12];
    int deflateStatus;
    do {
        zlibStreamStruct.next_out = [compressedData mutableBytes] + zlibStreamStruct.total_out;
        zlibStreamStruct.avail_out = (uInt)([compressedData length] - zlibStreamStruct.total_out);
        deflateStatus = deflate(&zlibStreamStruct, Z_FINISH);
    } while (deflateStatus == Z_OK);
    
    // Check for zlib error and convert code to usable error message if appropriate
    if (deflateStatus != Z_STREAM_END) {
        NSString *errorMsg = nil;
        switch (deflateStatus)
        {
            case Z_ERRNO:
                errorMsg = @"Error occured while reading file.";
                break;
            case Z_STREAM_ERROR:
                errorMsg = @"The stream state was inconsistent (e.g., next_in or next_out was NULL).";
                break;
            case Z_DATA_ERROR:
                errorMsg = @"The deflate data was invalid or incomplete.";
                break;
            case Z_MEM_ERROR:
                errorMsg = @"Memory could not be allocated for processing.";
                break;
            case Z_BUF_ERROR:
                errorMsg = @"Ran out of output buffer for writing compressed bytes.";
                break;
            case Z_VERSION_ERROR:
                errorMsg = @"The version of zlib.h and the version of the library linked do not match.";
                break;
            default:
                errorMsg = @"Unknown error code.";
                break;
        }
        NSLog(@"%s: zlib error while attempting compression: \"%@\" Message: \"%s\"", __func__, errorMsg, zlibStreamStruct.msg);
        // Free data structures that were dynamically created for the stream.
        deflateEnd(&zlibStreamStruct);
        return nil;
    }
    // Free data structures that were dynamically created for the stream.
    deflateEnd(&zlibStreamStruct);
    [compressedData setLength: zlibStreamStruct.total_out];
    return compressedData;
}

+ (NSData *)decompressData:(NSData *)compressedData {
    z_stream zStream;
    zStream.zalloc = Z_NULL;
    zStream.zfree = Z_NULL;
    zStream.opaque = Z_NULL;
    zStream.avail_in = 0;
    zStream.next_in = 0;
    
    int status = inflateInit2(&zStream, (15+32));
    
    if (status != Z_OK) {
        return nil;
    }
    
    Bytef *bytes = (Bytef *)[compressedData bytes];
    NSUInteger length = [compressedData length];
    NSUInteger halfLength = length/2;
    
    NSMutableData *uncompressedData = [NSMutableData dataWithLength:length+halfLength];
    
    zStream.next_in = bytes;
    zStream.avail_in = (unsigned int)length;
    zStream.avail_out = 0;
    NSInteger bytesProcessedAlready = zStream.total_out;
    
    while (zStream.avail_in != 0) {
        if (zStream.total_out - bytesProcessedAlready >= [uncompressedData length]) {
            [uncompressedData increaseLengthBy:halfLength];
        }
        zStream.next_out = (Bytef*)[uncompressedData mutableBytes] + zStream.total_out-bytesProcessedAlready;
        zStream.avail_out = (unsigned int)([uncompressedData length] - (zStream.total_out-bytesProcessedAlready));
        status = inflate(&zStream, Z_NO_FLUSH);
        if (status == Z_STREAM_END) {
            break;
        }
        else if (status != Z_OK) {
            return nil;
        }
    }
    status = inflateEnd(&zStream);
    if (status != Z_OK) {
        return nil;
    }
    [uncompressedData setLength: zStream.total_out-bytesProcessedAlready];  // Set real length
    return uncompressedData;
}

+ (NSString *)generateUUID {
    CFUUIDRef puuid = CFUUIDCreate(NULL);
    CFStringRef uuidString = CFUUIDCreateString(NULL, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    
    return [[result stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
}

+ (void)makeToast:(NSString *)message duration:(float)duration HeightScale:(float)scale {
    
    if(message.length>0){
        //zqq
        UIWindow *toastDisplaywindow = [[UIApplication sharedApplication] windows].lastObject;
        [toastDisplaywindow makeToast:message duration:duration HeightScale:scale];
    }
}

+ (void)makeAttributedToast:(NSAttributedString *)message duration:(float)duration HeightScale:(float)scale {
    
    UIWindow *toastDisplaywindow = [UIApplication sharedApplication].keyWindow;//[AppDelegate sharedInstance].window;
    
    for (UIWindow *w in [[UIApplication sharedApplication] windows]) {
        if (![[w class] isEqual:[UIWindow class]]) {
            toastDisplaywindow = w;
            break;
        }
    }
    [toastDisplaywindow makeAttributedToast:message duration:duration HeightScale:scale];
}

+ (void)addLeftBarButtonItem:(UIViewController *)vc item:(UIBarButtonItem *)item {
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        negativeSpacer.width = -5;
    } else {
        // Load resources for iOS 7 or later
        negativeSpacer.width = -16;
    }
    
    vc.navigationItem.leftBarButtonItems = @[negativeSpacer, item];
    //    vc.navigationItem.backBarButtonItem = item;
}

+ (void)addRightBarButtonItem:(UIViewController *)vc item:(UIBarButtonItem *)item {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        negativeSpacer.width = -5;
    }
    else {
        // Load resources for iOS 7 or later
        negativeSpacer.width = -15;
    }
    vc.navigationItem.rightBarButtonItems = @[negativeSpacer, item];
}

+ (void)addRightBarButtonItem:(UIViewController *)vc items:(NSArray *)items {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        negativeSpacer.width = -5;
    }
    else {
        // Load resources for iOS 7 or later
        negativeSpacer.width = -16;
    }
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:negativeSpacer];
    for (UIBarButtonItem *item in items) {
        [array addObject:item];
    }
    vc.navigationItem.rightBarButtonItems = array;
}

+ (UILabel *)custNavigationTitle:(NSString *)title {
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont systemFontOfSize:18.0f];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = title;
    return lbl;
}

+ (UILabel *)custNavigationTitle:(NSString *)title andColor:(UIColor *)color{
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = color;
    lbl.font = [UIFont systemFontOfSize:18.0f];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = title;
    return lbl;
}

+ (UILabel *)custNavigationAttributeTitle:(NSString *)title {
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont systemFontOfSize:16.0f];
    lbl.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:title];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x222222] range:NSMakeRange(0, 4)];
    [str addAttribute:NSForegroundColorAttributeName value:ViceTitleColor range:NSMakeRange(4, str.length-4)];
    lbl.attributedText = str;
    return lbl;
}

//自定义导航栏－标题
+ (UILabel *)custNavigationWithRect:(CGRect)rect title:(NSString *)title {
    UILabel *lbl = [[UILabel alloc] initWithFrame:rect];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont systemFontOfSize:18.0f];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = title;
    return lbl;
}

//add by Ting
+ (UIImage *)imageTensile:(UIImage *)image withEdgeInset:(UIEdgeInsets )edgeInsets{
    image = [image resizableImageWithCapInsets:edgeInsets];
    return image;
}

//判断手机号 add by Ting
+ (BOOL)isPhoneId:(NSString *)string {
    NSString * regex = @"^(1)[0-9]{10}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    
    return isMatch;
}

//画虚线
+ (void)drawDottedLine:(UIImageView *)img{
    UIGraphicsBeginImageContext(img.frame.size);   //开始画线
    [img.image drawInRect:CGRectMake(0, 0, img.frame.size.width, img.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    CGFloat lengths[] = {3,3};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor grayColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 5.0);    //开始画线
    CGContextAddLineToPoint(line, 310.0, 5.0);
    CGContextStrokePath(line);
    img.image = UIGraphicsGetImageFromCurrentImageContext();
}

//view转image
+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque , view.window.screen.scale);
    /* iOS 7 */
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    else /* iOS 6 */
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage* ret = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return ret;
}

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    //NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                char addrBuf[INET6_ADDRSTRLEN];
                if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    
    // The dictionary keys have the form "interface" "/" "ipv4 or ipv6"
    return [addresses count] ? addresses : nil;
}

+ (BOOL)isfloatString:(NSString *)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
    
}

+ (BOOL)isIntString:(NSString *)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+(BOOL) isMoneyWithStr:(NSString *)string {
    NSString * regex = @"^([0-9]+|[0-9]{1,3}(,[0-9]{3})*)(.[0-9]{1,2})?$";
    //    NSString * regex = @"^[0-9]{1,6}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMoney = [pred evaluateWithObject:string];
    
    return isMoney;
}

+(BOOL)isTrueStr:(NSString *)string{
    NSString * regex = @"[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……& amp;*（）——+|{}【】‘；：”“’。，、？]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMoney = [pred evaluateWithObject:string];
    return isMoney;
}

//  设置行间距
+ (void)setLineSpacing:(CGFloat)spacing label:(UILabel *)label{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    [label setAttributedText:attributedString];
    [label sizeToFit];
}

+(CGSize)trueSizeWithText:(NSString *)str labelWidth:(float)width labelTextFont:(CGFloat)font{
    CGSize trueSize = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return trueSize;
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

+ (NSString *)dataFormatter:(NSString *)formatter timeStamp:(NSString *)timeStamp {
    
    if (timeStamp.length > 0) {
        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        [df setDateFormat:formatter];
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:[timeStamp floatValue]];
        return [df stringFromDate:date];
    }else {
        return @"";
    }
}

+ (id)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    if ([jsonString isKindOfClass:[NSString class]]){
        
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if(err) {
            NSLog(@"json解析失败：%@",err);
            return nil;
        }
        return dic;
    }else {
        return jsonString;
    }
    
}

+ (NSString *)dicToJsonString:(NSDictionary *)dic {
    
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
    
}

+ (NSString *)stringWithArr:(NSArray *)strArr intervalStr:(NSString *)intervalStr{
    NSString *completeStr = [[NSString alloc] initWithString:strArr[0]];
    for (int i = 1; i < strArr.count; i ++) {
        NSString *feildStr = strArr[i - 1];
        if (feildStr.length > 0) {
            completeStr = [completeStr stringByAppendingString:[NSString stringWithFormat:@"%@%@",intervalStr,strArr[i]]];
        }else{
            completeStr = [completeStr stringByAppendingString:strArr[i]];
        }
    }
    return completeStr;
}

+ (void)callNumber:(NSString *)phoneNumber{
    NSString *phoneStr = [phoneNumber stringByReplacingOccurrencesOfString:@"转" withString:@","];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneStr];
    CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
    if (version >= 10.0) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

+ (NSString *)timeStamp:(NSString *)timeStamp CovertTimeSetFormat:(NSString *)format{
    
    if ([NSString stringWithFormat:@"%@",timeStamp].length == 0||[timeStamp intValue]== 0) {
        return @"";
    }
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    NSString* reDateStr = [df stringFromDate:date];
    return reDateStr;
}


+ (NSString *)stringWithTimeStamp:(NSInteger )dateStamp {
//    直播banner友好时间
    NSInteger anHour = 3600;
    NSInteger aMinute = 60;
    
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    //将当前时间转化为时间戳
    NSTimeInterval currentDateStamp = [currentDate timeIntervalSince1970];

    //获取当前时间的小时单位（24小时制）
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"H"];
    NSInteger nowHour = [[formatter stringFromDate:currentDate] integerValue];
    //获取当前时间的分钟单位
    NSDateFormatter *minFormatter = [NSDateFormatter new];
    [minFormatter setDateFormat:@"m"];
    NSInteger nowMinute = [[minFormatter stringFromDate:currentDate] integerValue];
    //今天0点的时间戳
    NSInteger todayZeroClock = currentDateStamp - anHour * nowHour - aMinute * nowMinute;
    
    NSInteger todayZeroInterval = todayZeroClock - dateStamp;
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:dateStamp];
    //进行条件判断，满足不同的条件返回不同的结果
    NSDateFormatter *outputFormat = [NSDateFormatter new];
    if (todayZeroClock > dateStamp && todayZeroInterval < (24 * anHour) ) {
        [outputFormat setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天 %@",[outputFormat stringFromDate:date]];
    }else if (dateStamp > todayZeroClock && labs(todayZeroInterval) < (24 * anHour) ) {
        [outputFormat setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"今天 %@",[outputFormat stringFromDate:date]];
    }else if (dateStamp > todayZeroClock && labs(todayZeroInterval) > (24 * anHour) && labs(todayZeroInterval) < (48 * anHour) ) {
        [outputFormat setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"明天 %@",[outputFormat stringFromDate:date]];
    }else{
        
        [formatter setDateFormat:@"yyyy"];
        NSString * yearStr = [formatter stringFromDate:date];
        NSString *nowYear = [formatter stringFromDate:currentDate];
        
        if ([yearStr isEqualToString:nowYear]) {
            //在同一年
            [formatter setDateFormat:@"MM-dd HH:mm"];
            return [formatter stringFromDate:date];
        }else{
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            return [formatter stringFromDate:date];
        }
    }
    
//    else {
//        [outputFormat setDateFormat:@"yyy-MM-dd HH:mm"];
//        return [NSString stringWithFormat:@"%@",[outputFormat stringFromDate:date]];
//    }
    
}

+ (NSArray *)getRangeStr:(NSString *)text findText:(NSString *)findText{
    NSMutableArray *arrayRanges = [NSMutableArray new];
    if (findText == nil || [findText isEqualToString:@""]) {
        return nil;
    }
    NSRange rang = [text rangeOfString:findText];
    if (rang.location != NSNotFound && rang.length != 0) {
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];
        NSRange rang1 = {0,0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int i = 0;; i++)
        {
            if (0 == i) {
                location = rang.location + rang.length;
                length = text.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            }else
            {
                location = rang1.location + rang1.length;
                length = text.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            if (rang1.location == NSNotFound && rang1.length == 0) {
                break;
            }else
                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
        }
        return [arrayRanges copy];
    }
    return @[];
}

+ (NSString *)formateDate:(NSString *)dateString{
////    通用友好时间
//    @try {
//        // ------实例化一个NSDateFormatter对象
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//这里的格式必须和DateString格式一致
//
//        NSDate * nowDate = [NSDate date];
//
//        // ------将需要转换的时间转换成 NSDate 对象
//        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
//
//        // ------取当前时间和转换时间两个日期对象的时间间隔
//        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
//
//        // ------再然后，把间隔的秒数折算成天数和小时数：
//        NSString *dateStr = [[NSString alloc] init];
//
//        if (time<=60) {  //1分钟以内的
//
//            dateStr = @"刚刚";
//
//        }else if(time<=60*60){  //一个小时以内的
//
//            int mins = time/60;
//            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
//
//        }else if(time<=60*60*24){  //在两天内的
//
//            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
//            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
//            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
//
//            [dateFormatter setDateFormat:@"HH:mm"];
//            if ([need_yMd isEqualToString:now_yMd]) {
//                //在同一天
//                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
//            }else{
//                //昨天
//                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
//            }
//        }else {
//
//            [dateFormatter setDateFormat:@"yyyy"];
//            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
//            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
//
//            if ([yearStr isEqualToString:nowYear]) {
//                //在同一年
//                [dateFormatter setDateFormat:@"MM-dd"];
//                dateStr = [dateFormatter stringFromDate:needFormatDate];
//            }else{
//                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//                dateStr = [dateFormatter stringFromDate:needFormatDate];
//            }
//        }
//
//        return dateStr;
//    }
//    @catch (NSException *exception) {
//        return @"";
//    }
    return [self tansferformaterDateWithDate:dateString];
}


//通用友好时间格式新V1.5.0
+ (NSString *)tansferformaterDateWithDate:(NSString *)dateString
{
    //    通用友好时间
    @try {
        // ------实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//这里的格式必须和DateString格式一致
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        NSDate * nowDate = [NSDate date];
        // ------将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
//          NSLog(@"date:%@",needFormatDate);
        // ------取当前时间和转换时间两个日期对象的时间间隔
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
//         NSLog(@"time:%f",time);
        // ------再然后，把间隔的秒数折算成天数和小时数：
        NSString *dateStr = [[NSString alloc] init];
        
        if (time < 10 && time>=0) { //10s
            dateStr = @"刚刚";
        }else if(time<60 && time >=10){
            //10秒<=X<60s
            int sec = time;
            dateStr = [NSString stringWithFormat:@"%d秒前",sec];;
        }
        else if(time<60*60 && time >=60){
            //1分钟<=X<60分钟
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];;
        }else if(time<3600*24 && time >= 3600){
            //1小时<=X<24小时
            int hour = time/3600;
            dateStr = [NSString stringWithFormat:@"%d小时前",hour];
        }else if(time < 3600*24*2 && time >= 3600*24){
            //24小时<=X<48小时
            [dateFormatter setDateFormat:@"HH:mm"];
            dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];;
        }else if(time < 3600*24*3 && time >= 3600*24*2){
            //48小时<=X<72小时
            [dateFormatter setDateFormat:@"HH:mm"];
            dateStr = [NSString stringWithFormat:@"前天 %@",[dateFormatter stringFromDate:needFormatDate]];;
        }else if(time < 3600*24*7 && time >= 3600*24*3){
            //72小时<=X<7天
            int day = time/(3600*24);
            dateStr = [NSString stringWithFormat:@"%d天前",day];
        }else if(time < 3600*24*30 && time >= 3600*24*7){
            //72小时<=X<7天
            int week = time/(3600*24*7);
            dateStr = [NSString stringWithFormat:@"%d周前",week];
        }else{
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
        }
        if (dateStr.length == 0) {
            return @"";
        }
        return dateStr;
    }
    @catch (NSException *exception) {
        return @"";
    }

}


+ (NSString *)timeFormatted:(int)totalSeconds{
    
    //totalSeconds 毫秒
    int seconds = totalSeconds/1000 % 60;
    int minutes = (totalSeconds / 60 /1000) % 60;
    //    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

+ (UIImage *)imageFromView:(UIView *)theView  atFrame:(CGRect)rect{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(rect);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}

+ (UIImage *)fullScreenshots{
    
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    
    return  viewImage;
}

+ (NSMutableDictionary *)getURLParametersWithUrl:(NSString *)url {
    
    // 查找参数
    NSRange range = [url rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [url substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

+(NSString *)URLDecodedString:(NSString *)str{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280) {
        if (width>height) {
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }else{
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }
        //2.高度大于1280
    }else if(height>1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
    }else{
        
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}

+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}


+ (UIImage *)coreBlurImage:(UIImage *)image
           withBlurNumber:(CGFloat)blur {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage  *inputImage=[CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

/**
 是否包含emoji表情
 
 @param text 文本
 @return bool值
 */
+ (BOOL)textContainEmojiEmotion:(NSString*)text{
    __block BOOL returnValue =NO;
    [text enumerateSubstringsInRange:NSMakeRange(0, [text length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue =YES;
                }
            }else {
                // non surrogate
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}


/**
 删除emoji表情
 
 @param text
 @return 删除emoji表情后的文本
 */
+ (NSString*)deleteTextEmoji:(NSString*)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

/**
 裁剪指定尺寸图片
 
 @param originImage 要裁剪的图片
 @param size 目标size
 @return 裁剪后图片
 */
+ (UIImage*)clipImage:(UIImage*)originImage clipSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [originImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size
{
    CGSize originalsize = [originalImage size];
    //原图长宽均小于标准长宽的，不作处理返回原图
    if (originalsize.width<size.width && originalsize.height<size.height)
    {
        return originalImage;
    }
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    else if(originalsize.width > size.width || originalsize.height > size.height)
    {
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/size.width;
        CGFloat heightRate = originalsize.height/size.height;
        rate = widthRate>heightRate?heightRate:widthRate;
        CGImageRef imageRef = nil;
        if (heightRate>widthRate)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
        }
        else
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        return standardImage;
    }
    return originalImage;
}

+ (CGFloat)ts_textWith:(NSString*)text textFont:(UIFont*)font{
    CGFloat stringWidth = 0;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    if (text.length > 0) {
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        stringWidth =[text
                      boundingRectWithSize:size
                      options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:@{NSFontAttributeName:font}
                      context:nil].size.width;
#else
        
        stringWidth = [text sizeWithFont:font
                            constrainedToSize:size
                                lineBreakMode:NSLineBreakByCharWrapping].width;
#endif
    }
    return stringWidth;
}


+ (CGFloat)ts_textHeight:(NSString*)text textFont:(UIFont*)font{
    
    CGFloat stringHeight = 0;
    CGSize size = CGSizeMake(KDeviceWidth-30, MAXFLOAT);
    if (text.length > 0) {
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        stringHeight =[text
                      boundingRectWithSize:size
                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                      attributes:@{NSFontAttributeName:font}
                      context:nil].size.height;
#else
        
        stringHeight = [text sizeWithFont:font
                       constrainedToSize:size
                           lineBreakMode:NSLineBreakByCharWrapping].height;
#endif
    }
    return stringHeight;
}


+ (CGFloat)ts_textHeight:(NSString*)text textFont:(UIFont*)font textMaxWidth:(CGFloat)maxWidth{
    
    CGFloat stringHeight = 0;
    CGSize size = CGSizeMake(maxWidth, MAXFLOAT);
    if (text.length > 0) {
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        stringHeight =[text
                       boundingRectWithSize:size
                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                       attributes:@{NSFontAttributeName:font}
                       context:nil].size.height;
#else
        
        stringHeight = [text sizeWithFont:font
                        constrainedToSize:size
                            lineBreakMode:NSLineBreakByCharWrapping].height;
#endif
    }
    return stringHeight;
}

//判断当前整个字符串是否是网址链接
+ (BOOL)isUrlAddress:(NSString *)url
{
//    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *reg = @"^(http|https)://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
//    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
//    return [urlPredicate evaluateWithObject:urlStr];
    
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    
    if (url.length<=0) {
        return NO;
    }
    result = nil;
    trimmedStr = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        if (schemeMarkerRange.location == NSNotFound) {
            return NO;
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                 return YES;
            }
        }
    }
    return NO;
}

+ (BOOL)isEmail:(NSString*)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

//通用alertView
+ (void)createNormalAlertViewWithText:(NSString*)text cancelTitle:(NSString*)cancelTitle{
    
    UIAlertView *alert = [UIAlertView showWithTitle:@"温馨提醒" message:text cancelButtonTitle:cancelTitle otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
    }];
    [alert show];
    
}

+ (BOOL)isString:(id)string{
    
    if ([string isKindOfClass:[NSString class]]){
        return YES;
    }
        
    return NO;
}

+ (BOOL)isArray:(id)array{
    if ([array isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isDictionary:(id)dictionary{
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}


+ (BOOL)clearCaches {
    
    // 拿到cachePath路径的下一级目录的子文件夹
    // contentsOfDirectoryAtPath:error:递归
    // subpathsAtPath:不递归
    NSArray *subpathArray = [fileManager contentsOfDirectoryAtPath:cachePath error:nil];
    
    // 如果数组为空，说明没有缓存或者用户已经清理过，此时直接return
    if (subpathArray.count == 0) {
        
#ifdef DEBUG
        
        NSLog(@"此缓存路径很干净,不需要再清理了");
#else
        
#endif
        return NO;
    }
    
    NSError *error = nil;
    
    NSString *filePath = nil;
    
    BOOL flag = NO;
    
    for (NSString *subpath in subpathArray) {
        
        filePath = [cachePath stringByAppendingPathComponent:subpath];
        
        if ([fileManager fileExistsAtPath:cachePath]) {
            
            // 删除子文件夹
            BOOL isRemoveSuccessed = [fileManager removeItemAtPath:filePath error:&error];
            
            if (isRemoveSuccessed) { // 删除成功
                
                flag = YES;
            }
        }
    }
    if (NO == flag) {
        
#ifdef DEBUG
        
        NSLog(@"提示:您已经清理了所有可以访问的文件,不可访问的文件无法删除");  // 调试阶段才打印
#else
        
#endif
        
    }
    
    return flag;
    
}
@end

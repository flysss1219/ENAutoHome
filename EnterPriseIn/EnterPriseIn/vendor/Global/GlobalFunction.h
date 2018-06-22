/*****************************************************************************
 文件名称 :
 版权声明 : Copyright (C), 2010-2013 Easier Digital Tech. Co., Ltd.
 文件描述 : 全局函数
 ******************************************************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalFunction : NSObject

//
/******************************************************************************
 函数名称 : + (NSData *)compressData:(NSData *)uncompressedData
 函数描述 : 压缩NSData数据
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : N/A
 ******************************************************************************/
+ (NSData *)compressData:(NSData*)uncompressedData;

/******************************************************************************
 函数名称 : + (NSData *)decompressData:(NSData *)compressedData
 函数描述 : 解压缩NSData
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : N/A
 ******************************************************************************/
+ (NSData *)decompressData:(NSData *)compressedData;

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

+ (NSString *)generateUUID;

/**
 *  在屏幕上显示toast  by xdyang
 *
 *  @param message  显示的信息
 *  @param duration 显示的时间
 *  @param scale    在整个屏幕的位置, 从上到下 (0.0 - 1.0)
 */
+ (void)makeToast:(NSString *)message duration:(float)duration HeightScale:(float)scale;
+ (void)makeAttributedToast:(NSAttributedString *)message duration:(float)duration HeightScale:(float)scale;
//
//+ (void)addLeftBarButtonItem:(UIViewController *)vc item:(UIBarButtonItem *)item;
//
//+ (void)addRightBarButtonItem:(UIViewController *)vc item:(UIBarButtonItem *)item;
//
//+ (void)addRightBarButtonItem:(UIViewController *)vc items:(NSArray *)items;

////自定义导航栏－标题
//+ (UILabel *) custNavigationTitle:(NSString *)title;
//+ (UILabel *)custNavigationTitle:(NSString *)title andColor:(UIColor *)color;

////自定义导航栏－标题
//+ (UILabel *)custNavigationAttributeTitle:(NSString *)title;
////自定义导航栏－标题
//+ (UILabel *) custNavigationWithRect:(CGRect)rect title:(NSString *)title;
//
//+ (UIImage *)imageTensile:(UIImage *)image withEdgeInset:(UIEdgeInsets )edgeInsets;
//
////判断手机号 add by Ting
+ (BOOL) isPhoneId:(NSString *)string;
//+ (void )drawDottedLine:(UIImageView *)img;
+ (UIImage *)imageWithView:(UIView *)view;
//
//+ (NSString *)getIPAddress:(BOOL)preferIPv4;
//
//+ (NSDictionary *)getIPAddresses;

+ (BOOL)isfloatString:(NSString *)string;

+ (BOOL)isIntString:(NSString *)string;

+ (BOOL)isMoneyWithStr:(NSString *)string;

+ (BOOL)isTrueStr:(NSString *)string;

+ (void)setLineSpacing:(CGFloat)spacing label:(UILabel *)label;
//真实尺寸
+(CGSize)trueSizeWithText:(NSString *)str labelWidth:(float)width labelTextFont:(CGFloat)font;

//获取日期对应的星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

+ (NSString *)dataFormatter:(NSString *)formatter timeStamp:(NSString *)timeStamp;


+ (id)dictionaryWithJsonString:(NSString *)jsonString;

+(NSString *)URLDecodedString:(NSString *)str;

+ (NSString *)dicToJsonString:(NSDictionary *)dic;

//字符串拼接
+ (NSString *)stringWithArr:(NSArray *)strArr intervalStr:(NSString *)intervalStr;

+ (void)callNumber:(NSString *)phoneNumber;

//时间戳转换时间 format为YYYY-MM-dd HH:mm
+ (NSString *)timeStamp:(NSString *)timeStamp CovertTimeSetFormat:(NSString *)format;

+ (NSString *)stringWithTimeStamp:(NSInteger )dateStamp;

+ (NSArray *)getRangeStr:(NSString *)text findText:(NSString *)findText;

+ (NSString *)formateDate:(NSString *)dateString;

//通用友好时间格式新V1.5.0
+ (NSString *)tansferformaterDateWithDate:(NSString *)dateString;

+ (NSString *)timeFormatted:(int)totalSeconds;

//截取部分屏幕生成图片
+ (UIImage *)imageFromView:(UIView *)theView  atFrame:(CGRect)rect;

//截取window
+ (UIImage *)fullScreenshots;
//获取url参数
+ (NSMutableDictionary *)getURLParametersWithUrl:(NSString *)url;

//压缩图片
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage;

+(NSString *)getNowTimeTimestamp;

+ (UIImage *)coreBlurImage:(UIImage *)image
            withBlurNumber:(CGFloat)blur;


/**
 是否包含emoji表情

 @param text 文本
 @return bool值
 */
+ (BOOL)textContainEmojiEmotion:(NSString*)text;


/**
 删除emoji表情

 @param text
 @return 删除emoji表情后的文本
 */
+ (NSString*)deleteTextEmoji:(NSString*)text;

/**
 裁剪指定尺寸图片

 @param originImage 要裁剪的图片
 @param size 目标size
 @return 裁剪后图片
 */
+ (UIImage*)clipImage:(UIImage*)originImage clipSize:(CGSize)size;

+ (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size;

/**
 求一段文字width

 @param text 文本
 @param font 字体
 @return width
 */
+ (CGFloat)ts_textWith:(NSString*)text textFont:(UIFont*)font;

+ (CGFloat)ts_textHeight:(NSString*)text textFont:(UIFont*)font;

+ (CGFloat)ts_textHeight:(NSString*)text textFont:(UIFont*)font textMaxWidth:(CGFloat)maxWidth;

//判断当前整个字符串是否是网址链接
+ (BOOL)isUrlAddress:(NSString *)url;

+ (BOOL)isEmail:(NSString*)email;

//通用alertView
+ (void)createNormalAlertViewWithText:(NSString*)text cancelTitle:(NSString*)cancelTitle;

+ (BOOL)isString:(id)string;

+ (BOOL)isArray:(id)array;

+ (BOOL)isDictionary:(id)dictionary;

/**
 *  清理缓存
 */
+ (BOOL)clearCaches;
@end

//
//  LanguageLocalizableHelper.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/6.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "LanguageLocalizableHelper.h"

#define CNS @"zh-Hans"
#define EN @"en"
#define CURRENTLANGUAGE @"currentLanguage"


@interface LanguageLocalizableHelper()

@property (nonatomic,strong) NSBundle *currentBundle;

@end


@implementation LanguageLocalizableHelper


/**
 单例
 
 @return 实例
 */
+ (instancetype)shareInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        [self initLanguage];
    }
    return  self;
}

//初始化语言，默认是中文
-(void)initLanguage{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENTLANGUAGE];
    Language  language = [self getSystemLanguage];
    if (!number) {
        [[NSUserDefaults standardUserDefaults]setValue:@(language) forKey:CURRENTLANGUAGE];
    }
    [self setUpCurrentBundle:language];
}

- (Language)getSystemLanguage{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if ([currentLanguage isEqualToString:EN]) {
        return Language_en;
    }else{
        return Language_zh_Hans;
    }
}

- (void)setUpCurrentBundle:(Language)language{
    //获取当前的语言所在路径并且获取bundle，如果bundle不存在则创建
    NSString *language_Str = [self getStringWithLanguage:language];
    NSAssert(language_Str != nil, @"language的值有误");
    //在mainbundle下每种语言都会产生一个 语言名字.lproj 的文件，文件里面包含了对应的table（即strings文件）
    NSString *path = [[NSBundle mainBundle] pathForResource:language_Str ofType:@"lproj"];
    self.currentLanguage = language;
    [[NSUserDefaults standardUserDefaults] setValue:@(language) forKey:CURRENTLANGUAGE];
    self.currentBundle = [NSBundle bundleWithPath:path];
}


- (NSString*)getStringWithLanguage:(Language)language{
    switch (language) {
        case Language_zh_Hans:
            return @"zh_Hans";
            break;
        case  Language_en:
            return @"en";
        default:
            return nil;
            break;
    }
}

/**
 在当前的bundle下，根据key和table获取文本
 
 @param key key
 @param table table(实际上是对应的strings的文件名)
 @return 文本
 */
- (NSString *)getStringWithKey:(NSString *)key table:(NSString*)table{
    if (self.currentBundle) {
        return  NSLocalizedStringFromTableInBundle(key, @"ENAppLanguage", self.currentBundle, @"");
    }
    else{
        return NSLocalizedStringFromTable(key, table, @"");
    }
}

/**
 传入语言切换app语言并发出通知
 
 @param language 待切换的语言
 */
- (void)changeLanguage:(Language)language{
    
    if (language == self.currentLanguage) {
        return;
    }
    //改变当前的bundle
    [self setUpCurrentBundle:language];
    //发出通知，让其他控制器重新加载控制器（可以在APPDelagate里面设置）
    [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGEHADCHANGED object:self userInfo:nil];
    
}


@end

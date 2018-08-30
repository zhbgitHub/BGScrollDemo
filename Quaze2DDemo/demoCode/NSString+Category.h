//
//  NSString+Category.h
//  Quaze2DTest
//
//  Created by ioszhb on 2017/8/31.
//  Copyright © 2017年 ioszhb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (noNull)

+ (NSString *)str_noNull:(NSString *)sender;
+ (NSString *)str_noNull:(NSString *)sender defaults:(NSString *)defaultStr;

@end

@interface NSString (format)

/**
 转变为 货币格式..

 @param sender 待处理的字符
 @return 货币格式的字符串,eg:(99,878,000.45)
 */
+ (NSString *)str_currencyFormat:(NSString *)sender;

/**
 删除头尾的空格

 @param sender 待处理的字符
 @return 删除头尾的空格后的str, eg:(@" dfa sf  ") --> (@"dfa sf")
 */
+ (NSString *)str_leadAndTailSpace:(NSString *)sender;

/**
 删除冗余的空格,规范格式类似英语语句

 @param sender 待处理的字符
 @return 删除冗余的空格Str, eg:(@"hello   swift  !") --> (@"hello swift!")
 */
+ (NSString *)str_deleteDedundantSpace:(NSString *)sender;

/**
 删除所有空格,字符串紧密连接

 @param sender 待处理的字符
 @return 删除所有空格的Str, eg:(@"hello  swift ! \n  swift is   strong language") --> (@"helloswift!swiftisstronglanguage")
 */
+ (NSString *)str_deleteAllSpace:(NSString *)sender;
@end

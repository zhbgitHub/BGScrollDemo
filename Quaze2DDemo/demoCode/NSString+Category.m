//
//  NSString+Category.m
//  Quaze2DTest
//
//  Created by ioszhb on 2017/8/31.
//  Copyright © 2017年 ioszhb. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (noNull)

+ (NSString *)str_noNull:(id)sender
{
    if (sender == [NSNull null]){ return @"";}
    if ([sender isKindOfClass:[NSNull class]]) { return @"";}
    if (sender == nil) { return @"";}
    if ([sender isEqualToString:@"(null)"]) { return @"";}
    return sender;
}

+ (NSString *)str_noNull:(NSString *)sender defaults:(NSString *)defaultStr
{
    defaultStr = [NSString str_noNull:defaultStr];
    sender = [NSString str_noNull:sender];
    if ([sender isEqualToString:@""]) {
        sender = defaultStr;
    }
    return sender;
}

@end


@implementation NSString (format)

+ (NSString *)str_currencyFormat:(NSString *)sender
{
    if ([[NSString str_noNull:sender] isEqualToString:@""]) return @"0.00";
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    sender = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[sender doubleValue]]];
    return sender;
}

+ (NSString *)str_leadAndTailSpace:(NSString *)sender
{
    return [sender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


+ (NSString *)str_deleteDedundantSpace:(NSString *)sender
{
    if ([[NSString str_noNull:sender] isEqualToString:@""]) return @"";

    sender = [sender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *components = [sender componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self != ''"]];
    sender = [components componentsJoinedByString:@" "];
    return sender;
}

+ (NSString *)str_deleteAllSpace:(NSString *)sender
{
    if ([[NSString str_noNull:sender] isEqualToString:@""]) return @"";

    sender = [sender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *components = [sender componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"NOT (SELF in %@)", @[@" ", @"\t", @"\n", @"\\s"]]];
//    components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != '\\s'"]];
    sender = [components componentsJoinedByString:@""];
    return sender;
}

@end


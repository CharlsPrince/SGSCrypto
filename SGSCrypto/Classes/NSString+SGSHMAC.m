/*!
 *  @file NSString+SGSHMAC.m
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSString+SGSHMAC.h"
#import "NSData+SGSHMAC.h"

@implementation NSString (SGSHMAC)

// HMAC-MD5字符串
- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data hmacMD5StringWithKey:key];
}

// HMAC-SHA1字符串
- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data hmacSHA1StringWithKey:key];
}

// HMAC-SHA224字符串
- (NSString *)hmacSHA224StringWithKey:(NSString *)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data hmacSHA224StringWithKey:key];
}

// HMAC-SHA256字符串
- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data hmacSHA256StringWithKey:key];
}

// HMAC-SHA384字符串
- (NSString *)hmacSHA384StringWithKey:(NSString *)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data hmacSHA384StringWithKey:key];
}

// HMAC-SHA512字符串
- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data hmacSHA512StringWithKey:key];
}

@end

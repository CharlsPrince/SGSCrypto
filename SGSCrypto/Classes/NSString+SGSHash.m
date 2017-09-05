/*!
 *  @file NSString+SGSHash.m
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSString+SGSHash.h"
#import "NSData+SGSHash.h"

@implementation NSString (SGSHash)

// MD2字符串
- (NSString *)md2String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data md2String];
}

// MD4字符串
- (NSString *)md4String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data md4String];
}

// MD5字符串
- (NSString *)md5String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data md5String];
}

// SHA1字符串
- (NSString *)sha1String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data sha1String];
}

// SHA224字符串
- (NSString *)sha224String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data sha224String];
}

// SHA256字符串
- (NSString *)sha256String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data sha256String];
}

// SHA384字符串
- (NSString *)sha384String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data sha384String];
}

// SHA512字符串
- (NSString *)sha512String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data sha512String];
}

// CRC32字符串
- (NSString *)crc32String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return @"";
    
    return [data crc32String];
}

@end

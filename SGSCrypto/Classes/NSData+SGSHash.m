/*!
 *  @file NSData+SGSHash.m
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSData+SGSHash.h"
#import <CommonCrypto/CommonCrypto.h>
#include <zlib.h>

@implementation NSData (SGSHash)

// 私有方法，将C字符串转为十六进制NSString
- (NSString *)p_HexStringFromBytes:(const unsigned char *)bytes length:(size_t)length {
    if (strlen((char*)bytes) < length) return @"";
    
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    for (int i = 0; i < length; i++) {
        [result appendFormat:@"%02x", bytes[i]];
    }
    
    return result.copy;
}

// MD2字符串
- (NSString *)md2String {
    unsigned char result[CC_MD2_DIGEST_LENGTH] = {0};
    CC_MD2(self.bytes, (CC_LONG)self.length, result);
    return [self p_HexStringFromBytes:result length:CC_MD2_DIGEST_LENGTH];
}

// MD2数据
- (NSData *)md2Data {
    unsigned char result[CC_MD2_DIGEST_LENGTH] = {0};
    CC_MD2(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD2_DIGEST_LENGTH];
}

// MD4字符串
- (NSString *)md4String {
    unsigned char result[CC_MD4_DIGEST_LENGTH] = {0};
    CC_MD4(self.bytes, (CC_LONG)self.length, result);
    return [self p_HexStringFromBytes:result length:CC_MD4_DIGEST_LENGTH];
}

// MD4数据
- (NSData *)md4Data {
    unsigned char result[CC_MD4_DIGEST_LENGTH] = {0};
    CC_MD4(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD4_DIGEST_LENGTH];
}

// MD5字符串
- (NSString *)md5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH] = {0};
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [self p_HexStringFromBytes:result length:CC_MD5_DIGEST_LENGTH];
}

// MD5数据
- (NSData *)md5Data {
    unsigned char result[CC_MD5_DIGEST_LENGTH] = {0};
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

// SHA1字符串
- (NSString *)sha1String {
    unsigned char result[CC_SHA1_DIGEST_LENGTH] = {0};
    CC_SHA1(self.bytes, (CC_LONG)self.length, result);
    return [self p_HexStringFromBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

// SHA1数据
- (NSData *)sha1Data {
    unsigned char result[CC_SHA1_DIGEST_LENGTH] = {0};
    CC_SHA1(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

// SHA224字符串
- (NSString *)sha224String {
    unsigned char result[CC_SHA224_DIGEST_LENGTH] = {0};
    CC_SHA224(self.bytes, (CC_LONG)self.length, result);
    return [self p_HexStringFromBytes:result length:CC_SHA224_DIGEST_LENGTH];
}

// SHA224数据
- (NSData *)sha224Data {
    unsigned char result[CC_SHA224_DIGEST_LENGTH] = {0};
    CC_SHA224(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA224_DIGEST_LENGTH];
}

// SHA256字符串
- (NSString *)sha256String {
    unsigned char result[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(self.bytes, (CC_LONG)self.length, result);
    return [self p_HexStringFromBytes:result length:CC_SHA256_DIGEST_LENGTH];
}

// SHA256数据
- (NSData *)sha256Data {
    unsigned char result[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA256_DIGEST_LENGTH];
}

// SHA384字符串
- (NSString *)sha384String {
    unsigned char result[CC_SHA384_DIGEST_LENGTH] = {0};
    CC_SHA384(self.bytes, (CC_LONG)self.length, result);
    return [self p_HexStringFromBytes:result length:CC_SHA384_DIGEST_LENGTH];
}

// SHA384数据
- (NSData *)sha384Data {
    unsigned char result[CC_SHA384_DIGEST_LENGTH] = {0};
    CC_SHA384(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA384_DIGEST_LENGTH];
}

// SHA512字符串
- (NSString *)sha512String {
    unsigned char result[CC_SHA512_DIGEST_LENGTH] = {0};
    CC_SHA512(self.bytes, (CC_LONG)self.length, result);
    return [self p_HexStringFromBytes:result length:CC_SHA512_DIGEST_LENGTH];
}

// SHA512数据
- (NSData *)sha512Data {
    unsigned char result[CC_SHA512_DIGEST_LENGTH] = {0};
    CC_SHA512(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA512_DIGEST_LENGTH];
}


// CRC32字符串
- (NSString *)crc32String {
    uLong result = crc32(0, self.bytes, (uInt)self.length);
    return [NSString stringWithFormat:@"%08x", (uint32_t)result];
}

// CRC32
- (uint32_t)crc32 {
    uLong result = crc32(0, self.bytes, (uInt)self.length);
    return (uint32_t)result;
}

@end

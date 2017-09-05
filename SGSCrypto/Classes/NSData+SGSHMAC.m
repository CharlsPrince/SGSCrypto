/*!
 *  @file NSData+SGSHMAC.m
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSData+SGSHMAC.h"
#import <CommonCrypto/CommonCrypto.h>

// 私有方法，返回指定HMAC算法的大小
size_t p_sizeOfHMACEncriptWithAlgorithm(CCHmacAlgorithm alg) {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5:    size = CC_MD5_DIGEST_LENGTH;    break;
        case kCCHmacAlgSHA1:   size = CC_SHA1_DIGEST_LENGTH;   break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: size = 0; break;
    }
    
    return size;
}

// 私有方法，将C字符串转为十六进制NSString
NSString * p_HexStringFromBytes(const unsigned char * bytes, size_t length) {
    if (strlen((char*)bytes) < length) return @"";
    
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    for (int i = 0; i < length; i++) {
        [result appendFormat:@"%02x", bytes[i]];
    }
    
    return result.copy;
}



@implementation NSData (SGSHMAC)


// 私有方法，返回按照指定的HMAC字符串
- (NSString *)p_HMACStringUsingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key {
    size_t size = p_sizeOfHMACEncriptWithAlgorithm(alg);
    unsigned char result[size];
    const char *cKey = [key UTF8String];
    CCHmac(alg, cKey, strlen(cKey), self.bytes, self.length, result);
    
    return p_HexStringFromBytes(result, size);
}

// 私有方法，返回按照指定的HMAC数据
- (NSData *)p_HMACDataUsingAlg:(CCHmacAlgorithm)alg withKey:(NSData *)key {
    size_t size = p_sizeOfHMACEncriptWithAlgorithm(alg);
    unsigned char result[size];
    CCHmac(alg, [key bytes], key.length, self.bytes, self.length, result);
    
    return [NSData dataWithBytes:result length:size];
}

// HMAC-MD5字符串
- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    return [self p_HMACStringUsingAlg:kCCHmacAlgMD5 withKey:key];
}

// HMAC-MD5数据
- (NSData *)hmacMD5DataWithKey:(NSData *)key {
    return [self p_HMACDataUsingAlg:kCCHmacAlgMD5 withKey:key];
}

// HMAC-SHA1字符串
- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    return [self p_HMACStringUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

// HMAC-SHA1数据
- (NSData *)hmacSHA1DataWithKey:(NSData *)key {
    return [self p_HMACDataUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

// HMAC-SHA224字符串
- (NSString *)hmacSHA224StringWithKey:(NSString *)key {
    return [self p_HMACStringUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

// HMAC-SHA224数据
- (NSData *)hmacSHA224DataWithKey:(NSData *)key {
    return [self p_HMACDataUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

// HMAC-SHA256字符串
- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    return [self p_HMACStringUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

// HMAC-SHA256数据
- (NSData *)hmacSHA256DataWithKey:(NSData *)key {
    return [self p_HMACDataUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

// HMAC-SHA384字符串
- (NSString *)hmacSHA384StringWithKey:(NSString *)key {
    return [self p_HMACStringUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

// HMAC-SHA384数据
- (NSData *)hmacSHA384DataWithKey:(NSData *)key {
    return [self p_HMACDataUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

// HMAC-SHA512字符串
- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    return [self p_HMACStringUsingAlg:kCCHmacAlgSHA512 withKey:key];
}

// HMAC-SHA512数据
- (NSData *)hmacSHA512DataWithKey:(NSData *)key {
    return [self p_HMACDataUsingAlg:kCCHmacAlgSHA512 withKey:key];
}
@end

/*!
 *  @file NSData+SGSCipher.m
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSData+SGSCipher.h"
#include <CommonCrypto/CommonCrypto.h>


@implementation NSData (SGSCipher)

// AES加密
- (NSData *)aesEncryptWithKey:(NSData *)key iv:(NSData *)iv {
    return [self p_CryptWithOperation:kCCEncrypt algorithm:kCCAlgorithmAES128 key:key iv:iv];
}


// AES解密
- (NSData *)aesDecryptWithKey:(NSData *)key iv:(NSData *)iv {
    return [self p_CryptWithOperation:kCCDecrypt algorithm:kCCAlgorithmAES128 key:key iv:iv];
}

// DES加密
- (NSData *)desEncryptWithKey:(NSData *)key iv:(NSData *)iv {
    return [self p_CryptWithOperation:kCCEncrypt algorithm:kCCAlgorithmDES key:key iv:iv];
}

// DES解密
- (NSData *)desDecryptWithKey:(NSData *)key iv:(NSData *)iv {
    return [self p_CryptWithOperation:kCCDecrypt algorithm:kCCAlgorithmDES key:key iv:iv];
}


/**
 *  加密或解密
 *
 *  @param op  加密操作或解密操作
 *  @param alg 算法
 *  @param key 密钥
 *  @param iv  引导
 *
 *  @return NSData or nil
 */
- (NSData *)p_CryptWithOperation:(CCOperation)op
                       algorithm:(CCAlgorithm)alg
                             key:(NSData *)key
                              iv:(NSData *)iv
{
    // 判断操作是否合法
    if (op != kCCEncrypt && op != kCCDecrypt) {
        return nil;
    }
    
    // AES
    if ((alg == kCCAlgorithmAES128) || (alg == kCCAlgorithmAES)) {
        // 判断AES的key的长度是否合法（16字节、24字节、32字节）
        if ((key.length != kCCKeySizeAES128) && (key.length != kCCKeySizeAES192) && (key.length != kCCKeySizeAES256)) {
            return nil;
        }
        
        // 如果是解密操作判断数据是否合法
        if ((op == kCCDecrypt) && (self.length % kCCBlockSizeAES128 != 0)) {
            return nil;
        }
    }
    
    // DES
    if (alg == kCCAlgorithmDES) {
        // 判断DES的key的长度是否合法（8字节）
        if (key.length != kCCKeySizeDES) {
            return nil;
        }
        
        // 如果是解密操作判断数据是否合法
        if ((op == kCCDecrypt) && (self.length % kCCBlockSizeDES != 0)) {
            return nil;
        }
    }
    
    // 如果存在初始化引导，判断初始化引导是否合法
    if ((iv.length != 0) && (iv.length != kCCBlockSizeAES128) && (iv.length != kCCBlockSizeDES)) {
        return nil;
    }
    
    size_t blockSize = 0;
    
    if (alg == kCCAlgorithmAES128 || alg == kCCAlgorithmAES) {
        blockSize = kCCBlockSizeAES128;
    }
    
    if (alg == kCCAlgorithmDES) {
        blockSize = kCCBlockSizeDES;
    }
    
    // 如果是加密操作，还需要加上块区域长度
    size_t padding = self.length + ((op == kCCEncrypt) ? blockSize : 0);
    
    void *buffer = malloc(padding);
    if (buffer == 0) return nil;
    
    size_t resultSize = 0;
    CCCryptorStatus cryptorStatus = CCCrypt(op,
                                            alg,
                                            ((iv == nil) ? kCCOptionECBMode : 0) | kCCOptionPKCS7Padding,
                                            key.bytes, key.length,
                                            iv.bytes,
                                            self.bytes, self.length,
                                            buffer, padding,
                                            &resultSize);
    NSData *result = nil;
    if (cryptorStatus == kCCSuccess) {
        result = [NSData dataWithBytes:buffer length:resultSize];
    }
    free(buffer);
    buffer = NULL;
    
    return result;
}

@end

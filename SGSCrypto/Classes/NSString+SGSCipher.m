/*!
 *  @file NSString+SGSCipher.m
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSString+SGSCipher.h"
#import "NSData+SGSCipher.h"

@implementation NSString (SGSCipher)

// AES加密
- (NSString *)aesEncryptWithKey:(NSData *)key iv:(NSData *)iv {
    NSStringEncoding encoding = NSUTF8StringEncoding;
    
    NSData *textData = [self dataUsingEncoding:encoding];
    if (textData == nil) return nil;
    
    NSData *encryption = [textData aesEncryptWithKey:key iv:iv];
    
    return [encryption base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

// AES解密
- (NSString *)aesDecryptWithKey:(NSData *)key iv:(NSData *)iv {
    if (self == nil) return nil;
    
    NSData *textData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (textData == nil) return nil;
    
    NSData *decryption = [textData aesDecryptWithKey:key iv:iv];
    
    return [[NSString alloc] initWithData:decryption encoding:NSUTF8StringEncoding];
}

// DES加密
- (NSString *)desEncryptWithKey:(NSData *)key iv:(NSData *)iv {
    NSStringEncoding encoding = NSUTF8StringEncoding;
    
    NSData *textData = [self dataUsingEncoding:encoding];
    if (textData == nil) return nil;
    
    NSData *encryption = [textData desEncryptWithKey:key iv:iv];
    
    return [encryption base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

// DES解密
- (NSString *)desDecryptWithKey:(NSData *)key iv:(NSData *)iv {
    if (self == nil) return nil;
    
    NSData *textData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (textData == nil) return nil;
    
    NSData *decryption = [textData desDecryptWithKey:key iv:iv];
    
    return [[NSString alloc] initWithData:decryption encoding:NSUTF8StringEncoding];
}

@end

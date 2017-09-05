/*!
 *  @file NSString+SGSCipher.h
 *
 *  @abstract 字符串密文类别
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @category NSString (SGSCipher)
 *
 *  @brief 对 NSData 进行 DES/AES 加密或 DES/AES 解密
 */
@interface NSString (SGSCipher)

/*!
 *  @brief AES加密（PKCS#7）
 *
 *  @param key 密钥（128或192或256位长度）
 *  @param iv  初始化引导（128位）
 *
 *  @return 经过base64编码的密文
 */
- (nullable NSString *)aesEncryptWithKey:(NSData *)key iv:(nullable NSData *)iv;

/*!
 *  @brief AES解密（PKCS#7）
 *
 *  @discussion 待解密的字符串必须是base64编码的字符串
 *
 *  @param key 密钥（128或192或256位长度）
 *  @param iv  初始化引导（128位）
 *
 *  @return 解密后的字符串
 */
- (nullable NSString *)aesDecryptWithKey:(NSData *)key iv:(nullable NSData *)iv;


/*!
 *  @brief DES加密（PKCS#7）
 *
 *  @param key 密钥（64位长度）
 *  @param iv  初始化引导（64位）
 *
 *  @return 经过base64编码的密文
 */
- (nullable NSString *)desEncryptWithKey:(NSData *)key iv:(nullable NSData *)iv;

/*!
 *  @brief DES解密（PKCS#7）
 *
 *  @discussion 待解密的字符串必须是base64编码的字符串
 *
 *  @param key 密钥（64位长度）
 *  @param iv  初始化引导（64位）
 *
 *  @return 解密后的字符串
 */
- (nullable NSString *)desDecryptWithKey:(NSData *)key iv:(nullable NSData *)iv;

@end

NS_ASSUME_NONNULL_END

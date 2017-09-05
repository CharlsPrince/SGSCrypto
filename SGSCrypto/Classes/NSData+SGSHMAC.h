/*!
 *  @file NSData+SGSHMAC.h
 *
 *  @abstract NSData HMAC 类别
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @category NSData (SGSHMAC)
 *
 *  @brief NSData 哈希运算消息认证码
 */
@interface NSData (SGSHMAC)

/*!
 *  @brief HMAC-MD5 字符串，小写字母
 *
 *  @param key 密钥
 *
 *  @return HMAC-MD5 字符串
 */
- (NSString *)hmacMD5StringWithKey:(NSString *)key;

/*!
 *  @brief HMAC-MD5 数据
 *
 *  @param key 密钥
 *
 *  @return HMAC-MD5 数据
 */
- (NSData *)hmacMD5DataWithKey:(NSData *)key;

/*!
 *  @brief HMAC-SHA1 字符串，小写字母
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA1 字符串
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

/*!
 *  @brief HMAC-SHA1 数据
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA1 数据
 */
- (NSData *)hmacSHA1DataWithKey:(NSData *)key;

/*!
 *  @brief HMAC-SHA224 字符串，小写字母
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA224 字符串
 */
- (NSString *)hmacSHA224StringWithKey:(NSString *)key;

/*!
 *  @brief HMAC-SHA224 数据
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA224 数据
 */
- (NSData *)hmacSHA224DataWithKey:(NSData *)key;

/*!
 *  @brief HMAC-SHA256 字符串，小写字母
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA256 字符串
 */
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

/*!
 *  @brief HMAC-SHA256 数据
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA256 数据
 */
- (NSData *)hmacSHA256DataWithKey:(NSData *)key;

/*!
 *  @brief HMAC-SHA384 字符串，小写字母
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA384 字符串
 */
- (NSString *)hmacSHA384StringWithKey:(NSString *)key;

/*!
 *  @brief HMAC-SHA384 数据
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA384 数据
 */
- (NSData *)hmacSHA384DataWithKey:(NSData *)key;

/*!
 *  @brief HMAC-SHA512 字符串，小写字母
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA512 字符串
 */
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

/*!
 *  @brief HMAC-SHA512 数据
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA512 数据
 */
- (NSData *)hmacSHA512DataWithKey:(NSData *)key;

@end

NS_ASSUME_NONNULL_END

/*!
 *  @file NSString+SGSHMAC.h
 *
 *  @abstract 字符串 HMAC 类别
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @category NSString (SGSHMAC)
 *
 *  @brief NSData 哈希运算消息认证码
 */
@interface NSString (SGSHMAC)

/*!
 *  @brief HMAC-MD5 字符串，小写字母
 *
 *  @param key 密钥
 *
 *  @return HMAC-MD5 字符串
 */
- (NSString *)hmacMD5StringWithKey:(NSString *)key;

/*!
 *  @brief HMAC-SHA1 字符串，小写字母
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA1 字符串
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

/*!
 *  @brief HMAC-SHA224 字符串，小写字母
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA224 字符串
 */
- (NSString *)hmacSHA224StringWithKey:(NSString *)key;

/*!
 *  @brief HMAC-SHA256 字符串，小写字母
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA256 字符串
 */
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

/*!
 *  @brief HMAC-SHA384 字符串，小写字母
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA384 字符串
 */
- (NSString *)hmacSHA384StringWithKey:(NSString *)key;

/*!
 *  @brief HMAC-SHA512 字符串，小写字母
 *
 *  @param key 密钥
 *
 *  @return HMAC-SHA512 字符串
 */
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

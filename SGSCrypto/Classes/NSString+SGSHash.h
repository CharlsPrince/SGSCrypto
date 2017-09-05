/*!
 *  @file NSString+SGSHash.h
 *
 *  @abstract 字符串散列值类别
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @category NSString (SGSHash)
 *
 *  @brief NSString 哈希算法
 */
@interface NSString (SGSHash)

/*!
 *  @brief MD2 字符串，小写字母
 *
 *  @return MD2 字符串
 */
- (NSString *)md2String;

/*!
 *  @brief MD4 字符串，小写字母
 *
 *  @return MD4 字符串
 */
- (NSString *)md4String;

/*!
 *  @brief MD5 字符串，小写字母
 *
 *  @return MD5 字符串
 */
- (NSString *)md5String;

/*!
 *  @brief SHA1 字符串，小写字母
 *
 *  @return SHA1 字符串
 */
- (NSString *)sha1String;

/*!
 *  @brief SHA224 字符串，小写字母
 *
 *  @return SHA224 字符串
 */
- (NSString *)sha224String;

/*!
 *  @brief SHA256 字符串，小写字母
 *
 *  @return SHA256 字符串
 */
- (NSString *)sha256String;

/*!
 *  @brief SHA384 字符串，小写字母
 *
 *  @return SHA384 字符串
 */
- (NSString *)sha384String;

/*!
 *  @brief SHA512 字符串，小写字母
 *
 *  @return SHA512 字符串
 */
- (NSString *)sha512String;

/*!
 *  @brief CRC32 校验字符串，小写字母
 *
 *  @return CRC32 校验字符串
 */
- (NSString *)crc32String;

@end

NS_ASSUME_NONNULL_END

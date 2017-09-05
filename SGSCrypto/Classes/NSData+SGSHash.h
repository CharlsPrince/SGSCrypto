/*!
 *  @file NSData+SGSHash.h
 *
 *  @abstract NSData 散列值类别
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @category NSData (SGSHash)
 *
 *  @brief NSData 哈希算法
 *
 *  @note 需要引入 libz.tbd
 */
@interface NSData (SGSHash)

/*!
 *  @brief MD2 字符串，小写字母
 *
 *  @return MD2 字符串
 */
- (NSString *)md2String;

/*!
 *  @brief MD2 数据
 *
 *  @return MD2 数据
 */
- (NSData *)md2Data;

/*!
 *  @brief MD4 字符串，小写字母
 *
 *  @return MD4 字符串
 */
- (NSString *)md4String;

/*!
 *  @brief MD4 数据
 *
 *  @return MD4 数据
 */
- (NSData *)md4Data;

/*!
 *  @brief MD5 字符串，小写字母
 *
 *  @return MD5 字符串
 */
- (NSString *)md5String;

/*!
 *  @brief MD5 数据
 *
 *  @return MD5 数据
 */
- (NSData *)md5Data;

/*!
 *  @brief SHA1 字符串，小写字母
 *
 *  @return SHA1 字符串
 */
- (NSString *)sha1String;

/*!
 *  @brief SHA1 数据
 *
 *  @return SHA1 数据
 */
- (NSData *)sha1Data;

/*!
 *  @brief SHA224 字符串，小写字母
 *
 *  @return SHA224 字符串
 */
- (NSString *)sha224String;

/*!
 *  @brief SHA224 数据
 *
 *  @return SHA224 数据
 */
- (NSData *)sha224Data;

/*!
 *  @brief SHA256 字符串，小写字母
 *
 *  @return SHA256 字符串
 */
- (NSString *)sha256String;

/*!
 *  @brief SHA256 数据
 *
 *  @return SHA256 数据
 */
- (NSData *)sha256Data;

/*!
 *  @brief SHA384 字符串，小写字母
 *
 *  @return SHA384 字符串
 */
- (NSString *)sha384String;

/*!
 *  @brief SHA384 数据
 *
 *  @return SHA384 数据
 */
- (NSData *)sha384Data;

/*!
 *  @brief SHA512 字符串，小写字母
 *
 *  @return SHA512 字符串
 */
- (NSString *)sha512String;

/*!
 *  @brief SHA512 字符串
 *
 *  @return SHA512 字符串
 */
- (NSData *)sha512Data;

/*!
 *  @brief CRC32 校验字符串
 *
 *  @return CRC32 校验字符串
 */
- (NSString *)crc32String;

/*!
 *  @brief CRC32
 *
 *  @return CRC32
 */
- (uint32_t)crc32;

@end


NS_ASSUME_NONNULL_END

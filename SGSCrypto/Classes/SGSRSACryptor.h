/*!
 *  @file SGSRSACryptor.h
 *
 *  @abstract RSA 相关操作
 *
 *  @author Created by Lee on 16/4/29.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief RSA签名哈希算法类型
 */
typedef NS_ENUM(NSInteger, RSASignAlgorithm) {
    RSASignAlgorithmSHA1   = 0, //! SHA1
    RSASignAlgorithmMD5    = 1, //! MD5
    RSASignAlgorithmSHA224 = 2, //! SHA224
    RSASignAlgorithmSHA256 = 3, //! SHA256
    RSASignAlgorithmSHA384 = 4, //! SHA384
    RSASignAlgorithmSHA512 = 5, //! SHA512
};


/*!
 *  @brief RSA密钥位数，暂不支持 4096 bit
 */
typedef NS_ENUM(NSInteger, RSAKeySizeInBits) {
    RSAKeySizeInBits512  = 0, //! 512 bit
    RSAKeySizeInBits1024 = 1, //! 1024 bit
    RSAKeySizeInBits2048 = 2, //! 2048 bit
};



/*!
 *  @class SGSRSACryptor
 *
 *  @brief RSA加密与解密操作类
 */
@interface SGSRSACryptor : NSObject

#pragma mark - 加密
///-----------------------------------------------------------------------------
/// @name 加密
///-----------------------------------------------------------------------------

/*!
 *  @brief RSA加密字符串（PKCS#1填充格式）
 *
 *  @param string 待加密的字符串
 *  @param key    公钥
 *
 *  @return 加密后的Base64字符串
 */
+ (nullable NSString *)encryptString:(NSString *)string withPublickKey:(SecKeyRef)key;



/*!
 *  @brief RSA加密数据（PKCS#1填充格式）
 *
 *  @discussion 由于RSA加密会耗费一些资源，如果需要加密大量的数据，请使用多线程
 *
 *  @param data 待加密的数据
 *  @param key  公钥
 *
 *  @return 加密后的数据
 */
+ (nullable NSData *)encryptData:(NSData *)data withPublicKey:(SecKeyRef)key;

#pragma mark - 解密
///-----------------------------------------------------------------------------
/// @name 解密
///-----------------------------------------------------------------------------

/*!
 *  @brief RSA解密字符串（PKCS#1填充格式）
 *
 *  @param string 待解密的字符串
 *  @param key    私钥
 *
 *  @return 解密后的字符串
 */
+ (nullable NSString *)decryptString:(NSString *)string withPrivateKey:(SecKeyRef)key;


/*!
 *  @brief RSA解密数据（PKCS#1填充格式）
 *
 *  @discussion 由于RSA解密会耗费一些资源，如果需要解密大量的数据，请使用多线程
 *
 *  @param data 待解密的数据
 *  @param key  私钥
 *
 *  @return 解密后的数据
 */
+ (nullable NSData *)decryptData:(NSData *)data withPrivateKey:(SecKeyRef)key;


#pragma mark - 签名认证
///-----------------------------------------------------------------------------
/// @name 签名认证
///-----------------------------------------------------------------------------

/*!
 *  @brief 使用公钥对数字签名和数据进行验证（PKCS#1填充格式）
 *
 *  @discussion 默认签名算法类型为SHA1
 *
 *  @param data          待验证数据
 *  @param signatureData 签名
 *  @param key           公钥
 *
 *  @return YES（合法数据），NO（非法数据）
 */
+ (BOOL)verifyData:(NSData *)data andSignatureData:(NSData *)signatureData withPublicKey:(SecKeyRef)key;



/*!
 *  @brief 使用公钥对数字签名和数据进行验证（PKCS#1填充格式）
 *
 *  @param data          待验证数据
 *  @param signatureData 签名
 *  @param key           公钥
 *  @param alg           签名算法类型
 *
 *  @return YES（合法数据），NO（非法数据）
 */
+ (BOOL)verifyData:(NSData *)data andSignatureData:(NSData *)signatureData withPublicKey:(SecKeyRef)key algorithm:(RSASignAlgorithm)alg;


/*!
 *  @brief 使用私钥对数据进行摘要并生成数字签名（PKCS#1填充格式）
 *
 *  @discussion 默认签名算法类型为SHA1
 *
 *  @param data 待签名的数据
 *  @param key  私钥
 *
 *  @return 签名 or nil
 */
+ (nullable NSData *)signData:(NSData *)data withPrivateKey:(SecKeyRef)key;


/*!
 *  @brief 根据私钥和指定的算法生成数字签名（PKCS#1填充格式）
 *
 *  @param data 待签名的数据
 *  @param key  私钥
 *  @param alg  签名算法类型
 *
 *  @return 签名 or nil
 */
+ (nullable NSData *)signData:(NSData *)data withPrivateKey:(SecKeyRef)key algorithm:(RSASignAlgorithm)alg;



#pragma mark - 密钥
///-----------------------------------------------------------------------------
/// @name 密钥
///-----------------------------------------------------------------------------

/*!
 *  @brief 生成1024bit的密钥对
 *
 *  @discussion
 *  公钥只能用于：加密、认证签名、打包
 *
 *  私钥只能用于：解密、签名、解包
 *
 *  如果希望生成的公钥和私钥能有更多用途，请使用 OSStatus SecKeyGeneratePair(CFDictionaryRef, SecKeyRef *, SecKeyRef *);
 *
 *  @param publicKey  公钥指针
 *  @param privateKey 私钥指针
 *
 *  @return 如果成功生成密钥对返回nil，否则返回相应的Error
 *
 *  @see <Security/SecKey.h>
 */
+ (nullable NSError *)generateRSAKeyPair:(SecKeyRef * __nullable CF_RETURNS_RETAINED)publicKey
                              privateKey:(SecKeyRef * __nullable CF_RETURNS_RETAINED)privateKey;


/*!
 *  @brief 生成指定长度的密钥对
 *
 *  @discussion
 *  公钥只能用于：加密、认证签名、打包
 *
 *  私钥只能用于：解密、签名、解包
 *
 *  如果希望生成的公钥和私钥能有更多用途，请使用 OSStatus SecKeyGeneratePair(CFDictionaryRef, SecKeyRef *, SecKeyRef *);
 *
 *  @param size       密钥对长度
 *  @param publicKey  公钥指针
 *  @param privateKey 私钥指针
 *
 *  @return 如果成功生成密钥对返回nil，否则返回相应的Error
 *  @see <Security/SecKey.h>
 */
+ (nullable NSError *)generateRSAKeyPairWithSize:(RSAKeySizeInBits)size
                                       publicKey:(SecKeyRef * __nullable CF_RETURNS_RETAINED)publicKey
                                      privateKey:(SecKeyRef * __nullable CF_RETURNS_RETAINED)privateKey;


/*!
 *  @brief 从DER文件中获取公钥（X.509 规范）
 *
 *  @param path DER文件路径
 *
 *  @return 公钥 or NULL
 */
+ (nullable SecKeyRef)publicKeyFromDERFileWithPath:(NSString *)path;


/*!
 *  @brief 从PEM文件中获取公钥
 *
 *  @param path PEM文件路径
 *
 *  @return 公钥 or NULL
 */
+ (nullable SecKeyRef)publicKeyFromPEMFileWithPath:(NSString *)path;


/*!
 *  @brief 从字符串中提取公钥
 *
 *  @param key 公钥字符串
 *
 *  @return 公钥 or NULL
 */
+ (nullable SecKeyRef)publicKeyWithString:(NSString *)key;


/*!
 *  @brief 使用模和指数生成RSA公钥
 *
 *  @param modulus  模
 *  @param exponent 指数（如果为空默认使用 65537，十六进制为：10001）
 *
 *  @return 公钥 or NULL
 */
+ (nullable SecKeyRef)publicKeyWithModulus:(NSData *)modulus andExponent:(nullable NSData *)exponent;


/*!
 *  @brief 从p12文件中获取私钥
 *
 *  @param path     p12文件路径
 *  @param password 证书密码
 *
 *  @return 私钥 or NULL
 */
+ (nullable SecKeyRef)privateKeyFromP12FileWithPath:(NSString *)path password:(nullable NSString *)password;


/*!
 *  @brief 从PEM文件中获取私钥
 *
 *  @discussion PEM 文件必须是 PKCS#8 格式，并且是无密码加密，一般用于跟 Java 服务器交互使用
 *
 *  @param path PEM文件路径
 *
 *  @return 私钥 or NULL
 */
+ (nullable SecKeyRef)privateKeyFromPKCS8PEMFileWithPath:(NSString *)path;


/*!
 *  @brief 从字符串中提取私钥
 *
 *  @discussion 字符串必须是 PKCS#8 格式，并且是无密码加密的文本，一般由 PEM 中文件获取
 *
 *  私钥字符串可以有头尾描述，也可以直接传入 Base-64 编码的密钥文本
 *
 *  通常 PKCS#1 格式私钥内容特征:
 *  @code
 *  无加密
 *      -----BEGIN RSA PRIVATE KEY-----
 *            BASE64 ENCODED DATA
 *      -----END RSA PRIVATE KEY-----  
 *
 *  加密
 *      -----BEGIN ENCRYPTED PRIVATE KEY-----
 *            BASE64 ENCODED DATA
 *      -----END ENCRYPTED PRIVATE KEY-----
 *  @endcode
 *
 *  PKCS#8 格式私钥内容特征:
 *  @code
 *  无加密
 *      -----BEGIN PRIVATE KEY-----
 *            BASE64 ENCODED DATA
 *      -----END PRIVATE KEY-----
 *
 *  加密
 *      -----BEGIN ENCRYPTED PRIVATE KEY-----
 *            BASE64 ENCODED DATA
 *      -----END ENCRYPTED PRIVATE KEY-----
 *  @endcode
 *
 *  @param key 私钥字符串
 *
 *  @return 私钥 or NULL
 */
+ (nullable SecKeyRef)privateKeyWithPKCS8String:(NSString *)key;

@end

/*!
 *  @brief 公钥存入钥匙串的tag
 */
FOUNDATION_EXPORT NSString * const SGSPublicKeyTag;

/*!
 *  @brief 私钥存入钥匙串的tag
 */
FOUNDATION_EXPORT NSString * const SGSPrivateKeyTag;

NS_ASSUME_NONNULL_END

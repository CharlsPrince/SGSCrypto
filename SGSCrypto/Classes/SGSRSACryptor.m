/*!
 *  @file SGSRSACryptor.m
 *
 *  @author Created by Lee on 16/4/29.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "SGSRSACryptor.h"
#import <CommonCrypto/CommonDigest.h>

NSString * const SGSPublicKeyTag = @"com.southgis.iMobile.key.public";
NSString * const SGSPrivateKeyTag = @"com.southgis.iMobile.key.private";


typedef NS_ENUM(NSUInteger, RSAOperation) {
    kRSAOperationEncrypt  = 0,  // 加密操作
    kRSAOperationDecrypt  = 1,  // 解密操作
};


/// 获取哈希签名与填充格式
NSArray * kSignatureDigestWithAlgorithm(RSASignAlgorithm alg, NSData *data) {
    // 哈希长度与算法
    size_t size;
    unsigned char * (*algorithm)(const void * , CC_LONG , unsigned char *) = NULL;
    SecPadding padding;
    
    switch (alg) {
        case RSASignAlgorithmSHA1: {   // SHA1
            size = CC_SHA1_DIGEST_LENGTH;
            algorithm = CC_SHA1;
            padding = kSecPaddingPKCS1SHA1;
        } break;
            
        case RSASignAlgorithmMD5: {    // MD5
            size = CC_MD5_DIGEST_LENGTH;
            algorithm = CC_MD5;
            padding = kSecPaddingPKCS1MD5;
        } break;
            
        case RSASignAlgorithmSHA224: { // SHA224
            size = CC_SHA224_DIGEST_LENGTH;
            algorithm = CC_SHA224;
            padding = kSecPaddingPKCS1SHA224;
        } break;
            
        case RSASignAlgorithmSHA256: { // SHA256
            size = CC_SHA256_DIGEST_LENGTH;
            algorithm = CC_SHA256;
            padding = kSecPaddingPKCS1SHA256;
        } break;
            
        case RSASignAlgorithmSHA384: { // SHA384
            size = CC_SHA384_DIGEST_LENGTH;
            algorithm = CC_SHA384;
            padding = kSecPaddingPKCS1SHA384;
        } break;
            
        case RSASignAlgorithmSHA512: { // SHA512
            size = CC_SHA512_DIGEST_LENGTH;
            algorithm = CC_SHA512;
            padding = kSecPaddingPKCS1SHA512;
        } break;
            
        default: { // 默认为SHA1
            size = CC_SHA1_DIGEST_LENGTH;
            algorithm = CC_SHA1;
            padding = kSecPaddingPKCS1SHA1;
        } break;
    }
    
    NSMutableData *resultData = [[NSMutableData alloc] initWithLength:size];
    
    (*algorithm)(data.bytes, (CC_LONG)data.length, resultData.mutableBytes);
    
    return @[resultData.copy, @(padding)];
}




@implementation SGSRSACryptor

#pragma mark - 加密

// 加密字符串
+ (NSString *)encryptString:(NSString *)string withPublickKey:(SecKeyRef)key {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [self encryptData:data withPublicKey:key];
    
    return [result base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}


// 加密数据
+ (NSData *)encryptData:(NSData *)data withPublicKey:(SecKeyRef)key {
    return [self p_RSACryptWithOperation:kRSAOperationEncrypt data:data key:key];
}


#pragma mark - 解密

/// 解密字符串
+ (NSString *)decryptString:(NSString *)string withPrivateKey:(SecKeyRef)key {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *result = [self decryptData:data withPrivateKey:key];
    
    if (result == nil) return nil;
    
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}


/// 解密数据
+ (NSData *)decryptData:(NSData *)data withPrivateKey:(SecKeyRef)key {
    return [self p_RSACryptWithOperation:kRSAOperationDecrypt data:data key:key];
}


#pragma mark - 签名认证

/// 使用公钥进行签名验证
+ (BOOL)verifyData:(NSData *)data
  andSignatureData:(NSData *)signatureData
     withPublicKey:(SecKeyRef)key
{
    uint8_t digest[CC_SHA1_DIGEST_LENGTH] = {0};
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    OSStatus status = SecKeyRawVerify(key, kSecPaddingPKCS1SHA1, digest, sizeof(digest), signatureData.bytes, signatureData.length);
    
    return (status == errSecSuccess);
}


/// 使用公钥进行签名验证
+ (BOOL)verifyData:(NSData *)data
  andSignatureData:(NSData *)signatureData
     withPublicKey:(SecKeyRef)key
         algorithm:(RSASignAlgorithm)alg
{
    NSArray *option = kSignatureDigestWithAlgorithm(alg, data);
    if (option.count != 2) return NO;
    
    const uint8_t *digest = [(NSData *)option[0] bytes];
    SecPadding padding = [(NSNumber *)option[1] unsignedIntValue];
    
    // 验证
    OSStatus status = SecKeyRawVerify(key, padding, digest, sizeof(digest), signatureData.bytes, signatureData.length);
    
    return (status == errSecSuccess);
}


/// 使用私钥生成签名
+ (NSData *)signData:(NSData *)data withPrivateKey:(SecKeyRef)key {
    uint8_t digest[CC_SHA1_DIGEST_LENGTH] = {0};
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableData *result = [[NSMutableData alloc] initWithLength:SecKeyGetBlockSize(key)];
    size_t resultDataLen = result.length;
    
    OSStatus status = SecKeyRawSign(key, kSecPaddingPKCS1SHA1, digest, sizeof(digest), result.mutableBytes, &resultDataLen);
    
    return (status == errSecSuccess) ? result.copy : nil;
}


/// 根据私钥和指定的算法生成数字签名
+ (NSData *)signData:(NSData *)data
      withPrivateKey:(SecKeyRef)key
           algorithm:(RSASignAlgorithm)alg
{
    NSArray *option = kSignatureDigestWithAlgorithm(alg, data);
    if (option.count != 2) return nil;
    
    const uint8_t *digest = [(NSData *)option[0] bytes];
    SecPadding padding = [(NSNumber *)option[1] unsignedIntValue];
    
    NSMutableData *result = [[NSMutableData alloc] initWithLength:SecKeyGetBlockSize(key)];
    size_t resultDataLen = result.length;
    
    OSStatus status = SecKeyRawSign(key, padding, digest, sizeof(digest), result.mutableBytes, &resultDataLen);
    
    return (status == errSecSuccess) ? result.copy : nil;
}



#pragma mark - 密钥

/// 生成1024bit的密钥对
+ (NSError *)generateRSAKeyPair:(SecKeyRef  _Nullable *)publicKey
                     privateKey:(SecKeyRef  _Nullable *)privateKey
{
    return [self generateRSAKeyPairWithSize:RSAKeySizeInBits1024 publicKey:publicKey privateKey:privateKey];
}


/// 生成指定长度的密钥对
+ (NSError *)generateRSAKeyPairWithSize:(RSAKeySizeInBits)size
                              publicKey:(SecKeyRef  _Nullable *)publicKey
                             privateKey:(SecKeyRef  _Nullable *)privateKey
{
    SInt32 keySizeInBits = 0;
    switch (size) {
        case RSAKeySizeInBits512:  keySizeInBits = 512; break;
        case RSAKeySizeInBits1024: keySizeInBits = 1024; break;
        case RSAKeySizeInBits2048: keySizeInBits = 2048; break;
        default: keySizeInBits = 1024; break;
    }
    
    CFNumberRef keySize  = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &keySizeInBits);
    const void *keys[]   = { kSecAttrKeyType, kSecAttrKeySizeInBits };
    const void *values[] = { kSecAttrKeyTypeRSA, keySize };
    
    CFDictionaryRef params = CFDictionaryCreate(kCFAllocatorDefault, keys, values, 2, NULL, NULL);
    
    OSStatus status = SecKeyGeneratePair(params, publicKey, privateKey);
    
    return (status == errSecSuccess) ? nil : [NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:nil];
}


/// 从DER文件中获取公钥
+ (SecKeyRef)publicKeyFromDERFileWithPath:(NSString *)path {
    NSData *certData = [NSData dataWithContentsOfFile:path];
    
    if (certData.length == 0) return NULL;
    
    // 证书Decode
    SecCertificateRef certificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)(certData));
    
    if (certificate == NULL) return NULL;
    
    // X.509规范
    SecPolicyRef policy = SecPolicyCreateBasicX509();
    
    // 验证
    SecTrustRef trust;
    OSStatus status = SecTrustCreateWithCertificates(certificate, policy, &trust);
    
    CFRelease(certificate);
    CFRelease(policy);
    
    if (status != errSecSuccess) return NULL;
    
    
    SecTrustResultType trustResult;
    status = SecTrustEvaluate(trust, &trustResult);
    
    if (status != errSecSuccess) {
        CFRelease(trust);
        return NULL;
    }
    
    // 公钥
    SecKeyRef publicKey = SecTrustCopyPublicKey(trust);
    
    CFRelease(trust);
    
    return publicKey;
}

/// 从PEM文件中获取公钥
+ (SecKeyRef)publicKeyFromPEMFileWithPath:(NSString *)path {
    NSString *keyStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (keyStr == nil) return NULL;

    return [self publicKeyWithString:keyStr];
}

/// 根据字符串提取公钥
+ (SecKeyRef)publicKeyWithString:(NSString *)key {
    key = [self p_trimKeyString:key
                 headerBoundary:@"-----BEGIN PUBLIC KEY-----"
                 footerBoundary:@"-----END PUBLIC KEY-----"];
    
    key = [self p_keyStringByStripWhitespaceAndNewline:key];

    NSData *data = [[NSData alloc] initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    data = [self p_stripPublicKeyHeader:data];
    if(data == nil) return NULL;
    
    return [self p_saveRSAKeyIntoKeychain:data appTag:SGSPublicKeyTag isPublicKey:YES];
}


/// 根据模和指数生成公钥
+ (SecKeyRef)publicKeyWithModulus:(NSData *)modulus andExponent:(NSData *)exponent {
    
    const uint8_t DEFAULT_EXPONENT[] = {0x01, 0x00, 0x01,};	// 默认: 65537
    const uint8_t UNSIGNED_FLAG_FOR_BYTE = 0x81;
    const uint8_t UNSIGNED_FLAG_FOR_BYTE2 = 0x82;
    const uint8_t UNSIGNED_FLAG_FOR_BIGNUM = 0x00;
    const uint8_t SEQUENCE_TAG = 0x30;
    const uint8_t INTEGER_TAG = 0x02;
    
    uint8_t *modulusBytes = (uint8_t*)modulus.bytes;
    uint8_t *exponentBytes = (uint8_t*)(exponent == nil ? DEFAULT_EXPONENT : exponent.bytes);
    
    // 1.计算长度
    
    // 模长度
    int lenMod = (int)modulus.length;
    if(modulusBytes[0] >= 0x80) lenMod ++;
    int lenModHeader = 2 + (lenMod >= 0x80 ? 1 : 0) + (lenMod >= 0x0100 ? 1 : 0);
    
    // 指数长度
    int lenExp = exponent == nil ? sizeof(DEFAULT_EXPONENT) : (int)exponent.length;
    int lenExpHeader = 2;
    
    // 实体长度
    int lenBody = lenModHeader + lenMod + lenExpHeader + lenExp;
    
    // 总长度
    int lenTotal = 2 + (lenBody >= 0x80 ? 1 : 0) + (lenBody >= 0x0100 ? 1 : 0) + lenBody;
    
    int index = 0;
    uint8_t *byteBuffer = malloc(sizeof(uint8_t) * lenTotal);
    memset(byteBuffer, 0x00, sizeof(uint8_t) * lenTotal);
    
    
    
    // 2.获取数据
    
    // sequence tag
    byteBuffer[index ++] = SEQUENCE_TAG;
    
    // 总长度
    if(lenBody >= 0x80) {
        byteBuffer[index ++] = (lenBody >= 0x0100 ? UNSIGNED_FLAG_FOR_BYTE2 : UNSIGNED_FLAG_FOR_BYTE);
    }
    
    if(lenBody >= 0x0100) {
        byteBuffer[index ++] = (uint8_t)(lenBody / 0x0100);
        byteBuffer[index ++] = lenBody % 0x0100;
    } else {
        byteBuffer[index ++] = lenBody;
    }
    
    // integer tag
    byteBuffer[index ++] = INTEGER_TAG;
    
    // 模长度
    if(lenMod >= 0x80) {
        byteBuffer[index ++] = (lenMod >= 0x0100 ? UNSIGNED_FLAG_FOR_BYTE2 : UNSIGNED_FLAG_FOR_BYTE);
    }
    
    if(lenMod >= 0x0100) {
        byteBuffer[index ++] = (int)(lenMod / 0x0100);
        byteBuffer[index ++] = lenMod % 0x0100;
    } else {
        byteBuffer[index ++] = lenMod;
    }
    
    
    if(modulusBytes[0] >= 0x80) {
        byteBuffer[index ++] = UNSIGNED_FLAG_FOR_BIGNUM;
    }
    
    memcpy(byteBuffer + index, modulusBytes, sizeof(uint8_t) * [modulus length]);
    index += [modulus length];
    
    
    byteBuffer[index ++] = INTEGER_TAG;
    byteBuffer[index ++] = lenExp;
    memcpy(byteBuffer + index, exponentBytes, sizeof(uint8_t) * lenExp);
    index += lenExp;
    
    if(index != lenTotal) return NULL;
    
    NSData *key = [[NSData alloc] initWithBytes:byteBuffer length:lenTotal];
    
    return [self p_saveRSAKeyIntoKeychain:key appTag:SGSPublicKeyTag isPublicKey:YES];
}


/// 从p12文件中获取私钥
+ (SecKeyRef)privateKeyFromP12FileWithPath:(NSString *)path password:(NSString *)password {
    NSData *pkcs12Data = [NSData dataWithContentsOfFile:path];
    
    if (pkcs12Data.length == 0) return NULL;
    
    
    NSDictionary *options = nil;
    if (password != nil) {
        options = @{(__bridge NSString *)kSecImportExportPassphrase : password};
    }
    
    // 验证
    CFArrayRef imported = NULL;
    OSStatus status = SecPKCS12Import((__bridge CFDataRef)pkcs12Data, (__bridge CFDictionaryRef)options, &imported);
    
    if (status != errSecSuccess) {
        CFRelease(imported);
        return NULL;
    }
    
    if (CFArrayGetCount(imported) != 1) {
        CFRelease(imported);
        return NULL;
    }
    
    NSDictionary *importedItem = (__bridge NSDictionary *)CFArrayGetValueAtIndex(imported, 0);
    
    CFRelease(imported);
    
    if (![importedItem isKindOfClass:[NSDictionary class]]) return NULL;
    
    // 获取证书
    SecIdentityRef identity = (__bridge SecIdentityRef)importedItem[(__bridge NSString *) kSecImportItemIdentity];
    
    if (identity == NULL) return NULL;
    
    // 私钥
    SecKeyRef privateKey = NULL;
    status = SecIdentityCopyPrivateKey(identity, &privateKey);
        
    if (status != errSecSuccess) return NULL;
        
    return privateKey;
}

+ (SecKeyRef)privateKeyFromPKCS8PEMFileWithPath:(NSString *)path {
    NSString *keyStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (keyStr == nil) return NULL;
    
    return [self privateKeyWithPKCS8String:keyStr];
}

/// 根据字符串提取私钥
+ (SecKeyRef)privateKeyWithPKCS8String:(NSString *)key {
    NSRange pkcs1 = [key rangeOfString:@"-----BEGIN RSA PRIVATE KEY-----"];
    NSRange pkcs8 = [key rangeOfString:@"-----BEGIN PRIVATE KEY-----"];
    
    if (pkcs1.length > 0) {
        key = [self p_trimKeyString:key
                     headerBoundary:@"-----BEGIN RSA PRIVATE KEY-----"
                     footerBoundary:@"-----END RSA PRIVATE KEY-----"];
    } else if (pkcs8.length > 0) {
        key = [self p_trimKeyString:key
                     headerBoundary:@"-----BEGIN PRIVATE KEY-----"
                     footerBoundary:@"-----END PRIVATE KEY-----"];
    }
    
    key = [self p_keyStringByStripWhitespaceAndNewline:key];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [self p_stripPrivateKeyHeader:data];
    if(data == nil) return nil;
    
    return [self p_saveRSAKeyIntoKeychain:data appTag:SGSPrivateKeyTag isPublicKey:NO];
}



#pragma mark - 私有方法

/// 对数据进行加密或解密操作
+ (NSData *)p_RSACryptWithOperation:(RSAOperation)op data:(NSData *)data key:(SecKeyRef)key {
    if (data == nil) return nil;
    if (key == NULL) return nil;
    
    // 密钥长度
    size_t bufferSize = SecKeyGetBlockSize(key) * sizeof(uint8_t);
    
    // 如果是解密操作，检查数据是否合法
    if (op == kRSAOperationDecrypt) {
        size_t mod = data.length % bufferSize;
        if (mod != 0) return nil;
    }
    
    // 临时数据缓冲区
    uint8_t *buffer = malloc(bufferSize * sizeof(uint8_t));
    memset((void *)buffer, 0x0, bufferSize);
    
    
    // 算法，分段大小
    OSStatus (*algorithm)(SecKeyRef , SecPadding , const uint8_t *, size_t , uint8_t *, size_t *) = NULL;
    size_t blockSize = 0;
    
    
    // 根据操作类型选择操作函数（加密或解密）以及分段大小
    switch (op) {
        case kRSAOperationEncrypt: {
            blockSize = bufferSize - 11;
            algorithm = SecKeyEncrypt;
        } break;
            
        case kRSAOperationDecrypt: {
            blockSize = bufferSize;
            algorithm = SecKeyDecrypt;
        } break;
            
        default:
            break;
    }
    
    // 分段数
    size_t  blockCount = (size_t )ceil(data.length / (double)blockSize);
    
    NSMutableData *result = [[NSMutableData alloc] initWithCapacity:blockSize * blockCount];
    
    // 分段加密或分段解密
    for (int i = 0; i < blockCount; i++) {
        
        unsigned long operateBufferSize = MIN(blockSize, data.length - i * blockSize);
        
        NSData *operateBuffer = [data subdataWithRange:NSMakeRange(i * blockSize, operateBufferSize)];
        
        OSStatus status = (*algorithm)(key,
                                       kSecPaddingPKCS1,
                                       (const uint8_t *)operateBuffer.bytes,
                                       operateBuffer.length,
                                       buffer,
                                       &bufferSize);
        
        
        if (status == errSecSuccess) {
            // 没有错误则将密文或明文写入result中
            NSData *tempBytes = [[NSData alloc] initWithBytes:(const void *)buffer length:bufferSize];
            [result appendData:tempBytes];
            
        } else {
            // 如果有错误则返回空结果
            if (buffer) {
                free(buffer);
            }
            
            return nil;
        }
    }
    
    // 加密或解密完毕
    if (buffer) {
        free(buffer);
    }
    
    return result.copy;
}

/// 去除密钥的首尾说明
+ (NSString *)p_trimKeyString:(NSString *)key headerBoundary:(NSString *)header footerBoundary:(NSString *)footer {
    NSRange spos = [key rangeOfString:header];
    if (spos.length > 0) {
        NSUInteger start = spos.location + spos.length;
        NSUInteger index = [key rangeOfComposedCharacterSequenceAtIndex:start].location;
        key = [key substringFromIndex:index];
    }
    
    NSRange epos = [key rangeOfString:footer];
    if (epos.length > 0) {
        NSUInteger index = [key rangeOfComposedCharacterSequenceAtIndex:epos.location].location;
        key = [key substringToIndex:index];
    }
    
    return key;
}

/// 去除密钥的换行符和空格
+ (NSString *)p_keyStringByStripWhitespaceAndNewline:(NSString *)key {
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    return key;
}

/// 去除公钥的头部 ASN.1
+ (NSData *)p_stripPublicKeyHeader:(NSData *)d_key{
    
    if (d_key == nil) return nil;
    
    unsigned long len = [d_key length];
    if (len == 0) return nil;
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx	 = 0;
    
    if (c_key[idx++] != 0x30) return nil;
    
    if (c_key[idx] > 0x80) {
        idx += c_key[idx] - 0x80 + 1;
    } else {
        idx++;
    }
    
    // PKCS #1
    static unsigned char seqiod[] = {
        0x30, 0x0d, 0x06, 0x09, 0x2a,
        0x86, 0x48, 0x86, 0xf7, 0x0d,
        0x01, 0x01, 0x01, 0x05, 0x00
    };
    
    if (memcmp(&c_key[idx], seqiod, 15)) return nil;
    
    idx += 15;
    
    if (c_key[idx++] != 0x03) return nil;
    
    if (c_key[idx] > 0x80) {
        idx += c_key[idx] - 0x80 + 1;
    } else {
        idx++;
    }
    
    if (c_key[idx++] != '\0') return nil;
    
    
    return([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}

/// 去除私钥的头部 ASN.1
+ (NSData *)p_stripPrivateKeyHeader:(NSData *)d_key{
    
    if (d_key == nil) return nil;
    
    unsigned long len = [d_key length];
    if (len == 0) return nil;
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx	 = 22;
    
    if (0x04 != c_key[idx++]) return nil;
    
    unsigned int c_len = c_key[idx++];
    int det = c_len & 0x80;
    
    if (det == 0) {
        c_len = c_len & 0x7f;
    } else {
        int byteCount = c_len & 0x7f;
        if (byteCount + idx > len) {
            return nil;
        }
        
        unsigned int accum = 0;
        unsigned char *ptr = &c_key[idx];
        idx += byteCount;
        while (byteCount) {
            accum = (accum << 8) + *ptr;
            ptr++;
            byteCount--;
        }
        c_len = accum;
    }
    
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
}


/// 将密钥保存到钥匙串中
+ (SecKeyRef)p_saveRSAKeyIntoKeychain:(NSData *)key appTag:(NSString *)appTag isPublicKey:(BOOL)isPublic {
    NSData *tag = [appTag dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    
    // 先移除之前的密钥
    [attr setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [attr setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [attr setObject:tag forKey:(__bridge id)kSecAttrApplicationTag];
    
    if (isPublic) {
        [attr setObject:(__bridge id)kSecAttrKeyClassPublic forKey:(__bridge id)kSecAttrKeyClass];
    } else {
        [attr setObject:(__bridge id)kSecAttrKeyClassPrivate forKey:(__bridge id)kSecAttrKeyClass];
    }
    
    SecItemDelete((__bridge CFDictionaryRef)attr);
    
    
    // 添加密钥到钥匙串中
    [attr setObject:@(YES) forKey:(__bridge id)kSecAttrIsPermanent];
    [attr setObject:key forKey:(__bridge id)kSecValueData];
    [attr setObject:@(YES) forKey:(__bridge id)kSecReturnPersistentRef];
    
    CFTypeRef persistKey = NULL;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)attr, &persistKey);
    
    if (persistKey != NULL) {
        CFRelease(persistKey);
    }
    
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return NULL;
    }
    
    [attr removeObjectForKey:(__bridge id)kSecAttrIsPermanent];
    [attr removeObjectForKey:(__bridge id)kSecValueData];
    [attr removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [attr setObject:@(YES) forKey:(__bridge id)kSecReturnRef];
    
    // 从钥匙串中获取密钥
    SecKeyRef keyRef = NULL;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)attr, (CFTypeRef *)&keyRef);
    
    if (status != noErr) return NULL;
    
    return keyRef;
}
@end

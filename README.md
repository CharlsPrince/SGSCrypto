# Southgis iOS(OC) 移动支撑平台组件 - 安全模块组件

[![CI Status](http://img.shields.io/travis/likun/SGSCrypto.svg?style=flat)](https://travis-ci.org/likun/SGSCrypto)
[![Version](https://img.shields.io/cocoapods/v/SGSCrypto.svg?style=flat)](http://cocoapods.org/pods/SGSCrypto)
[![License](https://img.shields.io/cocoapods/l/SGSCrypto.svg?style=flat)](http://cocoapods.org/pods/SGSCrypto)
[![Platform](https://img.shields.io/cocoapods/p/SGSCrypto.svg?style=flat)](http://cocoapods.org/pods/SGSCrypto)

------

**SGSCrypto**（OC版本）是移动支撑平台 iOS Objective-C 组件之一，该组件包含了常用的安全加密算法，以类别和类方法的方式快速实现数据与字符串的散列值计算和安全加密

## 安装
------
**SGSCrypto** 可以通过 **Cocoapods** 进行安装，可以复制下面的文字到 Podfile 中：

```ruby
target '项目名称' do
pod 'SGSCrypto', '~> 0.1.3'
end

仅加载常用哈希算法
target '项目名称' do
pod 'SGSCrypto/Hash', '~> 0.1.3'
end

仅加载常用哈希消息认证码算法
target '项目名称' do
pod 'SGSCrypto/HMAC', '~> 0.1.3'
end

仅加载 AES 和 DES 加解密的算法
target '项目名称' do
pod 'SGSCrypto/AESAndDES', '~> 0.1.3'
end

仅加载 RSA 算法
target '项目名称' do
pod 'SGSCrypto/RSA', '~> 0.1.3'
end

```

如果自行导入需要引入系统库 `libz.tbd` 该库在计算 **CRC32** 校验码时使用

添加方法：在工程的 `General` 板块的 `Linked Frameworks and Libraries` 选项中添加 `libz.tbd` 

## 功能
------
**SGSCrypto** 提供常用的散列值算法、DES 和 AES 加密，以 `NSData` 与 `NSString` 的类别形式获取。还可以通过 `SGSRSACryptor` 类来获取 RSA 的公钥、私钥以及数据的加密解密

> * 哈希算法
>  - MD2
>  - MD4
>  - MD5
>  - SHA1
>  - SHA224
>  - SHA256
>  - SHA384
>  - SHA512
> * 环冗余校验
>  - CRC32
> * 哈希运算消息认证码
>  - HMAC-MD5
>  - HMAC-SHA1
>  - HMAC-SHA224
>  - HMAC-SHA256
>  - HMAC-SHA384
>  - HMAC-SHA512
> * 加密与解密
>  - DES
>  - AES（128位、192位、256位的密钥长度）
>  - RSA

## 使用方法
------
### 哈希计算

可以通过 `NSData` 以及 `NSString` 的类别获取哈希和 CRC32 校验码

```
// 获取二进制数据的散列值
NSData *data = [NSData dataWithContentsOfFile:@"..."];

NSData *md2Data    = data.md2Data;
NSData *md4Data    = data.md4Data;
NSData *md5Data    = data.md5Data;
NSData *sha1Data   = data.sha1Data;
NSData *sha224Data = data.sha224Data;
NSData *sha256Data = data.sha256Data;
NSData *sha384Data = data.sha384Data;
NSData *sha512Data = data.sha512Data;

// 结果为十六进制数字（小写）形式的字符串
NSString *md2String    = data.md2String;
NSString *md4String    = data.md4String;
NSString *md5String    = data.md5String;
NSString *sha1String   = data.sha1String;
NSString *sha224String = data.sha224String;
NSString *sha256String = data.sha256String;
NSString *sha384String = data.sha384String;
NSString *sha512String = data.sha512String;

uint32_t crc32        = data.crc32;
NSString *crc32String = data.crc32String;  // 十六进制数字（小写）形式


// 获取字符串的散列值
NSString *msg = @"hello, world";

// 结果为十六进制数字（小写）形式的字符串
NSString *md2    = msg.md2String;
NSString *md4    = msg.md4String;
NSString *md5    = msg.md5String;
NSString *sha1   = msg.sha1String;
NSString *sha224 = msg.sha224String;
NSString *sha256 = msg.sha256String;
NSString *sha384 = msg.sha384String;
NSString *sha512 = msg.sha512String;
NSString *crc32  = msg.crc32String;
```

### 哈希运算消息认证码

可以通过 `NSData` 以及 `NSString` 的类别获取哈希运算消息认证码

```
NSString *key = @"3ef844506bad7c10";
NSData *keyData = dataWithHexString(key);

// 获取二进制数据的哈希运算消息认证码
NSData *data = [NSData dataWithContentsOfFile:@"..."];

NSData *hmacMD5Data    = [data hmacMD5DataWithKey:keyData];
NSData *hmacSHA1Data   = [data hmacSHA1DataWithKey:keyData];
NSData *hmacSHA224Data = [data hmacSHA224DataWithKey:keyData];
NSData *hmacSHA256Data = [data hmacSHA256DataWithKey:keyData];
NSData *hmacSHA384Data = [data hmacSHA384DataWithKey:keyData];
NSData *hmacSHA512Data = [data hmacSHA512DataWithKey:keyData];

// 结果为十六进制数字（小写）形式的字符串
NSString *hmacMD5String    = [data hmacMD5StringWithKey:key];
NSString *hmacSHA1String   = [data hmacSHA1StringWithKey:key];
NSString *hmacSHA224String = [data hmacSHA224StringWithKey:key];
NSString *hmacSHA256String = [data hmacSHA256StringWithKey:key];
NSString *hmacSHA384String = [data hmacSHA384StringWithKey:key];
NSString *hmacSHA512String = [data hmacSHA512StringWithKey:key];


// 获取字符串的哈希运算消息认证码
NSString *msg = @"hello, world";

// 结果为十六进制数字（小写）形式的字符串
NSString *hmacMD5    = [msg hmacMD5StringWithKey:key];
NSString *hmacSHA1   = [msg hmacSHA1StringWithKey:key];
NSString *hmacSHA224 = [msg hmacSHA224StringWithKey:key];
NSString *hmacSHA256 = [msg hmacSHA256StringWithKey:key];
NSString *hmacSHA384 = [msg hmacSHA384StringWithKey:key];
NSString *hmacSHA512 = [msg hmacSHA512StringWithKey:key];
```

### DES

可以通过 `NSData` 以及 `NSString` 的类别进行 DES 加密和解密操作

```
// 64位密钥
NSData *key = dataWithHexString(@"1a425b7c8e6d1032");

// 二进制数据
NSData *data = [NSData dataWithContentsOfFile:@"..."];

// DES 加密
NSData *encryption = [data desEncryptWithKey:key iv:nil];

// DES 解密
NSData *decryption = [encryption desDecryptWithKey:key iv:nil];


// 字符串
NSString *msg = @"hello, world";

// 经过 Base-64 编码的 DES 加密密文
NSString *encryptionStr = [msg desEncryptWithKey:key iv:nil];

// DES 解密字符串
NSString *decryptionStr = [encryptionStr desDecryptWithKey:key iv:nil];
```

### AES

可以通过 `NSData` 以及 `NSString` 的类别进行 AES 加密和解密操作

```
// 128位密钥
NSData *key = dataWithHexString(@"728e9a0294257c6a7b82f1d729436326");

// 二进制数据
NSData *data = [NSData dataWithContentsOfFile:@"..."];

// AES 加密
NSData *encryption = [data aesEncryptWithKey:key iv:nil];

// AES 解密
NSData *decryption = [encryption aesDecryptWithKey:key iv:nil];


// 字符串
NSString *msg = @"hello, world";

// 经过 Base-64 编码的 AES 加密密文
NSString *encryptionStr = [msg aesEncryptWithKey:key iv:nil];

// AES 解密字符串
NSString *decryptionStr = [encryptionStr aesDecryptWithKey:key iv:nil];
```

### RSA

可以通过 `SGSRSACryptor` 类获取 RSA 的公钥、私钥，进行加密、解密、签名认证等操作

#### 生成密钥对

可以生成 512 位、1024 位、2048位长度的密钥对

```
SecKeyRef publicKey  = NULL;
SecKeyRef privateKey = NULL;

// 生成1024位的密钥对
NSError *error = [SGSRSACryptor generateRSAKeyPair:&publicKey privateKey:&privateKey];

if (error) {
    NSLog(@"生成密钥对失败：%@", error);
} else {
    // 使用公钥和私钥进行加密或解密操作
}

// 生成2048位的密钥对
NSError *error2 = [SGSRSACryptor generateRSAKeyPairWithSize:RSAKeySizeInBits2048 publicKey:&publicKey privateKey:&privateKey];

if (error2) {
    NSLog(@"生成密钥对失败：%@", error);
} else {
    // 使用公钥和私钥进行加密或解密操作
}
```

#### 获取公钥和私钥

公钥：目前支持从 DER、PEM文件，以及字符串、模与指数的形式获取

私钥：目前支持从 p12、PEM文件，以及从字符串中获取

```
NSData *modulus = dataWithHexString(@"HexString");

// 公钥
SecKeyRef publicKeyFromDER    = [SGSRSACryptor publicKeyFromDERFileWithPath:@"DER File Path"];
SecKeyRef publicKeyFromPEM    = [SGSRSACryptor publicKeyFromPEMFileWithPath:@"PEM File Path"];
SecKeyRef publicKeyWithString = [SGSRSACryptor publicKeyWithString:@"Public Key String"];
// 如果指数为空默认使用 65537，十六进制为：10001
SecKeyRef publicKeyWithMAndE  = [SGSRSACryptor publicKeyWithModulus:modulus andExponent:nil];

// 私钥
SecKeyRef privateKeyFromP12    = [SGSRSACryptor privateKeyFromP12FileWithPath:@"P12 File Path" password:@"p12 password"];
SecKeyRef privateKeyFromPEM    = [SGSRSACryptor privateKeyFromPKCS8PEMFileWithPath:@"PEM File Path" password:@"p12 password"];
SecKeyRef privateKeyWithString = [SGSRSACryptor privateKeyWithPKCS8String:@"Private Key String"];
```

#### 加密与解密

可以分别对二进制数和字符串进行 RSA 加密或解密操作，如果操作的数据比较大，建议使用多线程

目前仅支持使用公钥加密，私钥解密的形式

```
// 待操作的二进制数据
NSData *data = [NSData dataWithContentsOfFile:@"..."];

// 加密二进制数据
NSData *encryption = [SGSRSACryptor encryptData:data withPublicKey:publicKey];

// 解密二进制数据
NSData *decryption = [SGSRSACryptor decryptData:encryption withPrivateKey:privateKey];

// 待操作的字符串
NSString *msg = @"hello, world";

// 经过 Base-64 编码的密文
NSString *encryptionString = [SGSRSACryptor encryptString:msg withPublickKey:publicKey];

// 解密还原后的字符串
NSString *decryptionString = [SGSRSACryptor decryptString:encryptionString withPrivateKey:privateKey];
```

#### 签名与认证

使用私钥对数据进行摘要并生成数字签名，签名算法可以 MD5、SHA1、SHA224、SHA256、SHA384、SHA512

使用公钥对数字签名和数据进行验证

```
NSData *data = [NSData dataWithContentsOfFile:@"..."];

// 签名
// 签名算法默认使用 SHA1
// 如果需要使用其他的签名算法，可以使用 -signData:withPrivateKey:algorithm:
NSData *sign = [SGSRSACryptor signData:data withPrivateKey:privateKey];

// 验证
// 签名算法默认使用 SHA1
// 如果需要使用其他的签名算法，可以使用 -verifyData:andSignatureData:withPublicKey:algorithm:
BOOL valid = [SGSRSACryptor verifyData:data andSignatureData:sign withPublicKey:publicKey];
```

## 结尾
------
**移动支撑平台** 是研发中心移动团队打造的一套移动端开发便捷技术框架。这套框架立旨于满足公司各部门不同的移动业务研发需求，实现App快速定制的研发目标，降低研发成本，缩短开发周期，达到代码的易扩展、易维护、可复用的目的，从而让开发人员更专注于产品或项目的优化与功能扩展

整体框架采用组件化方式封装，以面向服务的架构形式供开发人员使用。同时兼容 Android 和 iOS 两大移动平台，涵盖 **网络通信**, **数据持久化存储**, **数据安全**, **移动ArcGIS** 等功能模块（近期推出混合开发组件，只需采用前端的开发模式即可同时在 Android 和 iOS 两个平台运行），各模块间相互独立，开发人员可根据项目需求使用相应的组件模块

更多组件请参考：
> * [数据持久化存储组件](http://112.94.224.243:8081/kun.li/sgsdatabase/tree/master)
> * [HTTP 请求模块组件](http://112.94.224.243:8081/kun.li/sgshttpmodule/tree/master)
> * [ArcGIS绘图组件](https://github.com/crash-wu/SGSketchLayer-OC)
> * [常用类别组件](http://112.94.224.243:8081/kun.li/sgscategories/tree/master)
> * [常用工具组件](http://112.94.224.243:8081/kun.li/sgsutilities/tree/master)
> * [集合页面视图](http://112.94.224.243:8081/kun.li/sgscollectionpageview/tree/master)
> * [二维码扫描与生成](http://112.94.224.243:8081/kun.li/sgsscanner/tree/master)

如果您对移动支撑平台有更多的意见和建议，欢迎联系我们！

研发中心移动团队

2016 年 08月 29日    

## Author
------
Lee, kun.li@southgis.com

## License
------
SGSCrypto is available under the MIT license. See the LICENSE file for more info.

/*!
 *  @header
 *  @file SGSCrypto.h
 *
 *  @abstract 哈希算法与加解密类头文件
 *
 *  @author Created by Lee on 16/10/31.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#ifndef SGSCrypto_h
#define SGSCrypto_h

#if defined(__has_include) && __has_include(<SGSCrypto/SGSCrypto.h>)
#import <SGSCrypto/NSData+SGSHash.h>
#import <SGSCrypto/NSData+SGSHMAC.h>
#import <SGSCrypto/NSData+SGSCipher.h>
#import <SGSCrypto/NSString+SGSHash.h>
#import <SGSCrypto/NSString+SGSHMAC.h>
#import <SGSCrypto/NSString+SGSCipher.h>
#import <SGSCrypto/SGSRSACryptor.h>
#else
#import "NSData+SGSHash.h"
#import "NSData+SGSHMAC.h"
#import "NSData+SGSCipher.h"
#import "NSString+SGSHash.h"
#import "NSString+SGSHMAC.h"
#import "NSString+SGSCipher.h"
#import "SGSRSACryptor.h"
#endif


#endif /* SGSCrypto_h */

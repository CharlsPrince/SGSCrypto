#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SGSCrypto.h"
#import "NSData+SGSCipher.h"
#import "NSString+SGSCipher.h"
#import "NSData+SGSHMAC.h"
#import "NSString+SGSHMAC.h"
#import "NSData+SGSHash.h"
#import "NSString+SGSHash.h"
#import "SGSRSACryptor.h"

FOUNDATION_EXPORT double SGSCryptoVersionNumber;
FOUNDATION_EXPORT const unsigned char SGSCryptoVersionString[];


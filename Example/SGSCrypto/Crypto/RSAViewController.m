//
//  RSAViewController.m
//  SGSLibraryDemo
//
//  Created by Lee on 16/8/22.
//  Copyright © 2016年 arKenLee. All rights reserved.
//

#import "RSAViewController.h"
#import "SGSRSACryptor.h"

static NSString *kPublicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIDs9a4w7N+SXVhgAOtFmpfhEF\
zu148AGSdpp9fLYagA/neDqhjrGESUFUJ3xCBdWYiRxXo0umPl22aDnyfGqjZ+CQ\
HsdfXrJkOmkAp8pP1X0y37IJ5LIFxT6R6y4xgr0g4IYtGfia9NK6KoON3l7k/GkO\
4WGNlFsaFVtLj6nZZwIDAQAB";


static NSString *kPrivateKey = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAMgOz1rjDs35JdWG\
AA60Wal+EQXO7XjwAZJ2mn18thqAD+d4OqGOsYRJQVQnfEIF1ZiJHFejS6Y+XbZo\
OfJ8aqNn4JAex19esmQ6aQCnyk/VfTLfsgnksgXFPpHrLjGCvSDghi0Z+Jr00roq\
g43eXuT8aQ7hYY2UWxoVW0uPqdlnAgMBAAECgYAWqAa3pktA7FxqiBhtkeMtnMdU\
vxCJx7SF38SzPXJqIeKrNiR9s2lLL/ikDSy3VW3RLoX1LtscYqe+RqN5YLm6wFnC\
3AGf3vMOjL1+3zw4LBlxjLpFUYqgnpMnwHxIMgeKZALiCOVohXOZH1y43HnBGu/R\
RP9KHt5UNv+MFysIoQJBAPRne0fdanUKH84pkhpl0BdTleRKoI1myDloZy7xJKGB\
9fjbhAOGjD4Q5Ygo9wsWQxxoXl5IQBseXkJArLoqwmkCQQDRjLM8KnYH+nHSRhFU\
X8Jwf+ynHI/o2it/+qX0C6JbjI3pn41uw6+OHxPKXrhywPR+fw+um8gw239q8jop\
V6NPAkBdG7ssgp6W3feF6/JcGiNvb4lwAjouBFUNAcglavqgiMkzODWPvkdZMciv\
2aNb1uxUOzKQSogZjLUuGkNzXOzZAkBrGDOKLlFAZpjBVJoKux4OjPKPvaM26DmP\
ILSr8z44966XlbmcwFn6kpt0s9AkpcTO2XVUUb2Qar3GFKHw+x81AkBT4BW7B9Zc\
vqPqYXQmfyTzuRNDQsTZ8XiFZ4xp5xgc5g17wubjCsgokgJ++JK/xSQvcJasOWg+\
M11ycl7kkn+N";

@interface RSAViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSData *signData;
@end

@implementation RSAViewController

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

// 字符串公钥加密
- (IBAction)encryptWithPublickKeyString:(UIButton *)sender {
    NSString *text = _textField.text;
    
    if (text.length == 0) {
        showAlert(@"输入的信息不能为空", @"请重新输入", self);
        return;
    }

    SecKeyRef publicKey = [SGSRSACryptor publicKeyWithString:kPublicKey];
    NSString *encryption = [SGSRSACryptor encryptString:text withPublickKey:publicKey];
    
    if (encryption.length == 0) {
        _textView.text = @"加密失败";
    } else {
        _textView.text = [NSString stringWithFormat:@"加密结果：\n%@", encryption];
    }
}

// 字符串私钥解密
- (IBAction)decryptWithPrivateKeyString:(UIButton *)sender {
    NSString *text = _textField.text;
    
    if (text.length == 0) {
        showAlert(@"输入的信息不能为空", @"请重新输入", self);
        return;
    }
    
    SecKeyRef privateKey = [SGSRSACryptor privateKeyWithPKCS8String:kPrivateKey];
    NSString *decryption = [SGSRSACryptor decryptString:text withPrivateKey:privateKey];
    
    if (decryption.length == 0) {
        _textView.text = @"解密失败";
    } else {
        _textView.text = [NSString stringWithFormat:@"解密结果：\n%@", decryption];
    }
}

// DER公钥加密
- (IBAction)encryptWithPublicKey:(UIButton *)sender {
    NSString *text = _textField.text;

    if (text.length == 0) {
        showAlert(@"输入的信息不能为空", @"请重新输入", self);
        return;
    }

    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    SecKeyRef publicKey = [SGSRSACryptor publicKeyFromDERFileWithPath:publicKeyPath];
    
    NSString *encryption = [SGSRSACryptor encryptString:text withPublickKey:publicKey];
    
    if (encryption.length == 0) {
        _textView.text = @"加密失败";
    } else {
        _textView.text = [NSString stringWithFormat:@"加密结果：\n%@", encryption];
    }
}

// p12私钥解密
- (IBAction)decryptWithPrivateKey:(UIButton *)sender {
    NSString *text = _textField.text;

    if (text.length == 0) {
        showAlert(@"输入的信息不能为空", @"请重新输入", self);
        return;
    }
    
    NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    SecKeyRef privateKey = [SGSRSACryptor privateKeyFromP12FileWithPath:privateKeyPath password:@"test"];
    
    NSString *decryption = [SGSRSACryptor decryptString:text withPrivateKey:privateKey];
    
    if (decryption.length == 0) {
        _textView.text = @"解密失败";
    } else {
        _textView.text = [NSString stringWithFormat:@"解密结果：\n%@", decryption];
    }
}

// PEM公钥加密
- (IBAction)encryptWithPEMPublicKey:(UIButton *)sender {
    NSString *text = _textField.text;
    
    if (text.length == 0) {
        showAlert(@"输入的信息不能为空", @"请重新输入", self);
        return;
    }
    
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"pem"];
    SecKeyRef publicKey = [SGSRSACryptor publicKeyFromPEMFileWithPath:publicKeyPath];
    
    NSString *encryption = [SGSRSACryptor encryptString:text withPublickKey:publicKey];
    
    if (encryption.length == 0) {
        _textView.text = @"加密失败";
    } else {
        _textView.text = [NSString stringWithFormat:@"加密结果：\n%@", encryption];
    }
}

// PEM私钥解密
- (IBAction)decryptWithPEMPrivateKey:(UIButton *)sender {
    NSString *text = _textField.text;

    if (text.length == 0) {
        showAlert(@"输入的信息不能为空", @"请重新输入", self);
        return;
    }
    
    NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"pkcs8_private_key" ofType:@"pem"];
    SecKeyRef privateKey = [SGSRSACryptor privateKeyFromPKCS8PEMFileWithPath:privateKeyPath];
    
    NSString *decryption = [SGSRSACryptor decryptString:text withPrivateKey:privateKey];
    
    if (decryption.length == 0) {
        _textView.text = @"解密失败";
    } else {
        _textView.text = [NSString stringWithFormat:@"解密结果：\n%@", decryption];
    }
}

// 签名
- (IBAction)sign:(UIButton *)sender {
    NSString *text = _textField.text;
    
    if (text.length == 0) {
        showAlert(@"输入的信息不能为空", @"请重新输入", self);
        return;
    }
    
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    SecKeyRef privateKey = [SGSRSACryptor privateKeyFromP12FileWithPath:privateKeyPath password:@"test"];
    
    _signData = [SGSRSACryptor signData:data withPrivateKey:privateKey];
    NSString *signStr = [_signData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    if (signStr.length == 0) {
        _textView.text = @"签名失败";
    } else {
        _textView.text = [NSString stringWithFormat:@"签名：\n%@", signStr];
    }
}

// 认证
- (IBAction)verify:(UIButton *)sender {
    NSString *text = _textField.text;
    
    if (text.length == 0) {
        showAlert(@"输入的信息不能为空", @"请重新输入", self);
        return;
    }
    
    if (_signData == nil) {
        showAlert(@"未生成签名", nil, self);
        return;
    }
    
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    SecKeyRef publicKey = [SGSRSACryptor publicKeyFromDERFileWithPath:publicKeyPath];
    
    BOOL result = [SGSRSACryptor verifyData:data andSignatureData:_signData withPublicKey:publicKey];
    
    if (result) {
        _textView.text = @"认证通过";
    } else {
        _textView.text = @"认证失败";
    }
}

@end

//
//  DESAndAESViewController.m
//  SGSLibraryDemo
//
//  Created by Lee on 16/8/22.
//  Copyright © 2016年 arKenLee. All rights reserved.
//

#import "DESAndAESViewController.h"
#import "NSString+SGSCipher.h"

@interface DESAndAESViewController ()

@property (weak, nonatomic) IBOutlet UITextField *desTextField;
@property (weak, nonatomic) IBOutlet UILabel *desKeyLabel;
@property (weak, nonatomic) IBOutlet UITextView *desResultTextView;


@property (weak, nonatomic) IBOutlet UITextField *aesTextField;
@property (weak, nonatomic) IBOutlet UILabel *aesKeyLabel;
@property (weak, nonatomic) IBOutlet UITextView *aesResultTextView;

@end

@implementation DESAndAESViewController

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)tapContentView:(UITapGestureRecognizer *)sender {
    [sender.view endEditing:YES];
}


- (BOOL)checkMessage:(NSString *)msg {
    if (msg == nil || msg.length == 0) {
        showAlert(@"输入的信息不能为空", @"请重新输入", self);
        return NO;
    }
    
    return YES;
}

- (IBAction)desEncrypt:(UIButton *)sender {
    NSString *msg = _desTextField.text;
    
    if (![self checkMessage:msg]) {
        return;
    }
    
    // 将16进制字符串转为NSData
    NSData *key = dataWithHexString(_desKeyLabel.text);
    
    NSString *result = [NSString stringWithFormat:@"DES加密结果:\n\n%@\n", [msg desEncryptWithKey:key iv:nil]];
    _desResultTextView.text = result;
}

- (IBAction)desDecrypt:(id)sender {
    NSString *msg = _desTextField.text;
    
    if (![self checkMessage:msg]) {
        return;
    }
    
    // 将16进制字符串转为NSData
    NSData *key = dataWithHexString(_desKeyLabel.text);
    
    NSString *result = [NSString stringWithFormat:@"DES解密结果:\n\n%@\n", [msg desDecryptWithKey:key iv:nil]];
    _desResultTextView.text = result;
}

- (IBAction)aesEncrypt:(UIButton *)sender {
    NSString *msg = _aesTextField.text;
    
    if (![self checkMessage:msg]) {
        return;
    }
    
    // 将16进制字符串转为NSData
    NSData *key = dataWithHexString(_aesKeyLabel.text);
    
    NSString *result = [NSString stringWithFormat:@"AES加密结果:\n\n%@\n", [msg aesEncryptWithKey:key iv:nil]];
    _aesResultTextView.text = result;
}

- (IBAction)aesDecrypt:(UIButton *)sender {
    NSString *msg = _aesTextField.text;
    
    if (![self checkMessage:msg]) {
        return;
    }
    
    // 将16进制字符串转为NSData
    NSData *key = dataWithHexString(_aesKeyLabel.text);
    NSString *result = [NSString stringWithFormat:@"AES解密结果:\n\n%@\n", [msg aesDecryptWithKey:key iv:nil]];
    _aesResultTextView.text = result;
}

@end

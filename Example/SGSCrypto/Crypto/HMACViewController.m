//
//  HMACViewController.m
//  SGSLibraryDemo
//
//  Created by Lee on 16/8/22.
//  Copyright © 2016年 arKenLee. All rights reserved.
//

#import "HMACViewController.h"
#import "NSString+SGSHMAC.h"

static NSString *kResultFormat = @"计算结果:\n"\
@"MD5: %@\n"\
@"SHA1: %@\n"\
@"SHA224: %@\n"\
@"SHA256: %@\n"\
@"SHA384: %@\n"\
@"SHA512: %@\n";

@interface HMACViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation HMACViewController

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)hmac:(UIButton *)sender {
    NSString *msg = _textField.text;
    
    if (msg == nil || msg.length == 0) {
        showAlert(@"输入的信息不能为空", @"请重新输入", self);
        return ;
    }
    
    // 3ef844506bad7c10
    NSString *key = _keyLabel.text;
    
    if (key == nil || key.length == 0) {
        showAlert(@"密钥不能为空", @"请重新输入", self);
        return ;
    }
    
    NSString *hmacMD5    = [msg hmacMD5StringWithKey:key];
    NSString *hmacSHA1   = [msg hmacSHA1StringWithKey:key];
    NSString *hmacSHA224 = [msg hmacSHA224StringWithKey:key];
    NSString *hmacSHA256 = [msg hmacSHA256StringWithKey:key];
    NSString *hmacSHA384 = [msg hmacSHA384StringWithKey:key];
    NSString *hmacSHA512 = [msg hmacSHA512StringWithKey:key];
    
    NSString *result = [NSString stringWithFormat:kResultFormat, hmacMD5, hmacSHA1, hmacSHA224, hmacSHA256, hmacSHA384, hmacSHA512];
    
    // 段落样式
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineHeightMultiple = 1.5; // 多倍行距
    style.paragraphSpacing = 20.0;  // 段后间距
    
    // 属性字符串
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:result attributes:@{NSParagraphStyleAttributeName: style}];
    
    _textView.attributedText = attrStr;
}


@end

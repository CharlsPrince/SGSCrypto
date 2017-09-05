//
//  HashViewController.m
//  SGSLibraryDemo
//
//  Created by Lee on 16/8/22.
//  Copyright © 2016年 arKenLee. All rights reserved.
//

#import "HashViewController.h"
#import "NSString+SGSHash.h"

static NSString *kResultFormat = @"计算结果:\n"\
@"MD2: %@\n"\
@"MD4: %@\n"\
@"MD5: %@\n"\
@"SHA1: %@\n"\
@"SHA224: %@\n"\
@"SHA256: %@\n"\
@"SHA384: %@\n"\
@"SHA512: %@\n"\
@"CRC32: %@\n";

@interface HashViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation HashViewController


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (IBAction)hash:(UIButton *)sender {
    NSString *msg = _textField.text;
    
    if (msg == nil || msg.length == 0) {
        showAlert(@"输入的信息不能为空", @"请重新输入", self);
        return ;
    }
    
    NSString *md2    = msg.md2String;
    NSString *md4    = msg.md4String;
    NSString *md5    = msg.md5String;
    NSString *sha1   = msg.sha1String;
    NSString *sha224 = msg.sha224String;
    NSString *sha256 = msg.sha256String;
    NSString *sha384 = msg.sha384String;
    NSString *sha512 = msg.sha512String;
    NSString *crc32  = msg.crc32String;
    
    NSString *result = [NSString stringWithFormat:kResultFormat, md2, md4, md5, sha1, sha224, sha256, sha384, sha512, crc32];
    
    // 段落样式
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineHeightMultiple = 1.5; // 多倍行距
    style.paragraphSpacing = 20.0;  // 段后间距
    
    // 属性字符串
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:result attributes:@{NSParagraphStyleAttributeName: style}];
    
    _textView.attributedText = attrStr;
}


@end
